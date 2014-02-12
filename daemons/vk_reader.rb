require 'sidekiq'
require 'net/http'
require 'nokogiri'

require File.expand_path("../../app/workers/vk_bot_worker", __FILE__)

messages = {}

loop do
  response =  Net::HTTP.get_response(URI('http://m.vk.com/uldriver'))
  response.body.force_encoding("UTF-8")
  m = response.body.scan(/<.*?pi_text.*?>(.*?)<\/.*?<.*?pi_date.*?>(.*?)<\//)
  page = Nokogiri::HTML(response.body)
  page.css('.pi_body').each do |body|
    text = body.css('.pi_text')[0]
    if text
      text.text
      user = body.css('.pi_signed .user')[0]
      unless messages.has_key?(text.text)
        messages[text.text] = {
          author: user ? user.text : '',
          processed: false,
          time: Time.now
        }
      end
    end
  end
  p messages

  messages.reject!{ |k, v| v[:time] < (Time.now - 3600) }
  messages.each do |text, params|
    unless params[:processed]
      params[:processed] = true
      VkBotWorker.perform_async(text, params[:author], params[:time])
    end
  end

  p messages
  sleep(240)
end
