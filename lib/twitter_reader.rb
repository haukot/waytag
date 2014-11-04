class TwitterReader
  class << self
    def read_from(city)
      client = ServiceLocator.twitter_stream(city)

      puts "City #{city} connected \n"

      register_stream_callbacks(client, city)
    end

    def status_recived(status, city, source)
      puts "Status \"#{status.text}\" recived from #{source}"

      TwitterBotWorker.perform_async(ActiveSupport::JSON.encode(status), city, source)
    end

    def error(message)
      puts "Error #{message}\n"
      client.stop
      exit
    end

    def reconnect(timeout, retries)
      puts "Reconnected: #{timeout}, #{retries}\n"

      if retries > 10
        exit
      end
    end

    def limit(skip_count)
      puts "Rate limited #{skip_count} \n"
      exit
    end

    def enhance_your_calm
      puts 'Enhance you calm'
      exit
    end

    private

    def register_stream_callbacks(client, city)
      client.on_error do |message|
        error(message)
      end

      client.on_reconnect do |timeout, retries|
        reconnect(timeout, retries)
      end

      client.on_limit do |skip_count|
        limit(skip_count)
      end

      client.on_enhance_your_calm do
        enhance_your_calm
      end

      client.userstream do |status|
        EM.defer do
          status_recived(status, city, :mentions)
        end
      end

      client.track("##{city}way") do |status|
        EM.defer do
          status_recived(status, city, :hashtag)
        end
      end

      client
    end
  end
end
