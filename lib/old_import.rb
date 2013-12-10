class OldImport
  class << self
    def perform_users
      city = City.find_by slug: "ul"

      response = Net::HTTP.get tweet_url(city)
      meta = ActiveSupport::JSON.decode(response)

      c = 0
      meta["num_pages"].to_i.times do |page|
        response = Net::HTTP.get tweet_url(city, page)
        tweets = ActiveSupport::JSON.decode(response)
        tweets["tweets"].each do |t|
          unless TwitterUser.exists?(screen_name: t["screen_name"])
            p TwitterService.populate_user(t["mentor"]) if t["mentor"]
            c += 1
          end

          exit if c == 179
        end
      end

    end

    def perform
      City.find_each do |city|
        perform_city(city)
      end

      response = Net::HTTP.get all_url
      all = ActiveSupport::JSON.decode(response)

      city = City.find_by slug: "ul"
      all["bonuses"].each do |b|
        city.bonuses.find_or_create_by({
        title: b["name"],
        description: b["description"],
        })
      end

      all["posts"].each do |b|
        Post.find_or_create_by({
          user_name: b["name"],
          title: b["title"],
          content: b["content"],
          published_at: b["created_at"]
        })
      end

      all["black_list"].each do |b|
        sleep 10

        user = TwitterService.populate_user(b["screen_name"])
        user.deactivate if user
      end
    end

    def perform_city(city)
      response = Net::HTTP.get tweet_url(city)
      meta = ActiveSupport::JSON.decode(response)

      c = 0
      meta["num_pages"].to_i.times do |page|
        response = Net::HTTP.get tweet_url(city, page)
        tweets = ActiveSupport::JSON.decode(response)
        tweets["tweets"].each do |t|
          perform_tweet(city, t)
          print '.'
        end
        print " " + ((c / meta["num_pages"].to_i) * 100).to_i.to_s + "% "
      end
    end

    def perform_tweet(city, t)
      report = city.reports.build(
        time: t["created_at"],
        source_kind: source_kind(t),
        sourceable: sourceable(t),
        id_str: t["id_str"],
        event_kind: EventKinds.from_text(t["text"]),
        source_text: t["text"].gsub(/\[\d\d:\d\d\]\s*/, "").gsub(/\s*#ulway.*?$/, "")
      )

      if t["bayes"].to_i == -1
        Classifier.train(report.source_text, :good)
      elsif t["bayes"].to_i == 1
        Classifier.train(report.source_text, :bad)
      end

      report.state = t["status"].to_sym

      report.text = TextComposer.compose(report)
      report.save

      if report.has_duplicate?
        return report.destroy
      end
    end

    def sourceable(t)
      return TwitterService.populate_user(t["mentor"]) if t["mentor"]

      nil
    end

    def source_kind(t)
      return :web if t["source"].nil?
      return :web if t["source"] == "site"

      t["source"].to_sym
    end

    def tweet_url(city, page = 1, per_page = 50)
      URI("http://waytag.ru/api/cities/#{city.slug}/tweets.json?per_page=#{per_page}&page=#{page}&ololo=true")
    end

    def all_url
      URI("http://waytag.ru/api/cities/ul/tweets/all.json")
    end
  end
end
