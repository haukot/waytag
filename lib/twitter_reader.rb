class TwitterReader
  class << self

    def read_from(city)
      client = ServiceLocator.twitter_stream(city)

      client.filter(:track => "##{city}way") do |object|
        status_recived(object, city, :mentions) if object.is_a?(Twitter::Tweet)
      end

      client.user do |object|
        status_recived(object, city, :mentions) if object.is_a?(Twitter::Tweet)
      end

      puts "City #{city} connected \n"
    end

    def status_recived(status, city, source)
      puts "Status \"#{status.text}\" recived from #{source}"

      TwitterBotWorker.perform_async(ActiveSupport::JSON.encode(status), city, source)
    end

  end
end
