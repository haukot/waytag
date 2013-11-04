# encoding: utf-8

require 'test_helper'

class TwitterBotTest < ActiveSupport::TestCase
  setup do
    @status = ActiveSupport::JSON.decode(load_fixture('status.json'))

    GreenMidget::Classifier.new("ДТП ДПС пробка авария минаева").classify_as! :ham
    GreenMidget::Classifier.new("пизда джигурда").classify_as! :spam
  end

  def test_handle_status_i_love
    r = stub_request(:post, "https://api.twitter.com/1.1/direct_messages/new.json").
      with(:body => {"text"=>"I love you tooo!", "user_id"=>"216778941"}).
      to_return(:status => 200, :body => "", :headers => {})

    TwitterBot.handle_status(load_fixture('status_i_love.json'), 'ul', 'hashtag')

    assert_requested r
  end

  def test_handle_status_repost
    TwitterBot.handle_status(load_fixture('status.json'), 'ul', 'hashtag')
  end

  def test_questions
    @status["text"] = '[10:59] @Sekreeet да в курсе, уже парочка таких? имеется)) #ulway via @fire_beard'
    assert TwitterBot.question? @status

    @status["text"] = '@[10:59] @Sekreeet да в курсе, уже парочка таких имеется)) #ulway via @fire_beard'
    assert !(TwitterBot.question? @status)
  end

  def test_more_two_mentions
    @status["text"] = '[10:59] @Sekreeet да в курсе, уже парочка таких имеется)) #ulway via @fire_beard'
    assert TwitterBot.more_two_mentions? @status

    @status["text"] = '@asd asd asduhieudhk dalsju '
    assert !(TwitterBot.more_two_mentions? @status)
  end

end
