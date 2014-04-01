package main

import (
  "github.com/PuerkitoBio/goquery"
  "fmt"
  "time"
  "strings"
  "unicode/utf8"
  "crypto/md5"
  "encoding/hex"
  "github.com/garyburd/redigo/redis"
  "os"
  "encoding/json"
)

type Message struct {
  userId string
  userName string
  text string
  time time.Time
  processed bool
}

type JobMessage struct {
  Class string `json:"class"`
  Args [4]string `json:"args"`
  Jid string `json:"jid"`
  Retry bool `json:"retry"`
}

func ExtractMessage(s *goquery.Selection) (Message) {
  text := s.Find(".pi_text").Text()
  userName := s.Find(".pi_signed .user").Text()
  userId, _ := s.Find(".pi_signed .user").Attr("href")
  userId = strings.Trim(userId, "/")
  t := time.Now()

  return Message{ userId: userId, userName: userName, text: text, time: t, processed: false }
}

func (m Message) checkSum() string {
  h := md5.New()
  h.Write([]byte(m.text))

  return hex.EncodeToString(h.Sum(nil))
}

func exec(storage map[string]*Message, conn redis.Conn) {
  var doc *goquery.Document
  var e error

  if doc, e = goquery.NewDocument("http://m.vk.com/uldriver"); e != nil {
    // TODO return error from exec
    panic(e.Error())
  }

  doc.Find(".pi_body").Each(func(i int, s *goquery.Selection) {
    m := ExtractMessage(s)
    l := utf8.RuneCountInString(m.text)

    _, present := storage[m.checkSum()]
    if l > 10 && l <= 140 && !present {
      storage[m.checkSum()] = &m
    }
  })

  for key, _ := range storage {
    value := storage[key]
    fmt.Println("Key:", key, "Value:", value)
    if !value.processed {

      m := JobMessage{"VkBotWorker", [4]string{value.text, value.userName, value.time.String(), value.userId}, key, false}

      b, err := json.Marshal(m)
      if err != nil {
        // TODO return error from exec
        panic(err.Error())
      }

      conn.Send("LPUSH", "queue:default", b)
      conn.Flush()
      value.processed = true
    }
  }
}

func clearOldMessages(storage map[string]*Message) {
  for key, value := range storage {
    expires := time.Now().Add(-time.Hour * 7)

    if value.time.After(expires) {
      delete(storage, key)
    }
  }
}

func main () {
  c, err := redis.Dial("tcp", ":6379")

  if err != nil {
    fmt.Println("Redis connection failed on port 6379")
    os.Exit(2)
  }

  defer c.Close()

  storage := make(map[string]*Message)

  execChan := time.NewTicker(time.Second * 7).C
  clearChan := time.NewTicker(time.Hour * 7).C

  for {
    select {
    case <- execChan:
      exec(storage, c)
    case <- clearChan:
      clearOldMessages(storage)
    }
  }
}
