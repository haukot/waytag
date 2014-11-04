# encoding: utf-8
class TwitterService
  class << self
    def populate_user(screen_name)
      user = TwitterUser.find_by_screen_name screen_name
      return user if user

      client = ServiceLocator.waytag_twitter
      params = client.user(screen_name).to_h

      tup = TwitterUserPopulator.new params
      tup.populate
    rescue Twitter::Error => e
      Rails.logger.fatal "Twitter error #{e}"
      nil
    end

    def destroy(report)
      if report.id_str
        c = client(report.city)
        c.destroy_status(report.id_str.to_i)
      end
    rescue Twitter::Error => e
      Rails.logger.fatal "Twitter error #{e}"
    end

    def update(report)
      c = client(report.city)

      #      if report.map_picture
      #        response = c.update_with_media(report.safe_text, image(report))
      #      else
      response = c.update(report.decorate.safe_text)
      #      end

      report.id_str = response.id.to_s
      report.save
      report.post
    rescue Twitter::Error::Forbidden => e
      Rails.logger.fatal "Tweet rejected #{e}"
      nil
    end

    private

    def image(report)
      open(report.map_picture)
    end

    def client(city)
      ServiceLocator.twitter(city.slug)
    end
  end
end
