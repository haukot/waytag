require 'sidekiq'
require 'net/http'
require 'nokogiri'

require File.expand_path("../../app/workers/vk_bot_worker", __FILE__)

messages = {}

loop do
  response =  Net::HTTP.get_response(URI('http://m.vk.com/uldriver'))
  response.body.force_encoding("UTF-8")
  page = Nokogiri::HTML(response.body)
  page.css('.pi_body').each do |body|
    text = body.css('.pi_text')[0]
    if text
      text = text.text.to_s
      user = body.css('.pi_signed .user')[0]
      unless messages.has_key?(text)
        if text.length <= 140
          messages[text] = {
            author: user ? user.text.to_s : '',
            id: user ? user[:href].gsub(/^\//, '') : '',
            processed: false,
            time: Time.now
          }
        end
      end
    end
  end

  messages.reject!{ |k, v| v[:time] < (Time.now - 3600 * 24) }
  messages.each do |text, params|
    unless params[:processed]
      params[:processed] = true

      VkBotWorker.perform_async(text, params[:author], params[:time], params[:id])
    end
  end

  p messages
  sleep(240)
end
