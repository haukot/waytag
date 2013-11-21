#encoding: utf-8
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@city.twitter_name} - Дорожная обстановка в г. #{@city.name}"
    xml.description "Waytag.ru - Дорожная обстановка в вашем городе"
    xml.link rss_url @city

    for message in @messages
      xml.item do
        xml.title message.text
        xml.description ""
        xml.pubDate message.created_at.to_s(:rfc822)
        xml.link "https://twitter.com/#{message.city.twitter_name}/status/#{message.id_str}"
      end
    end
  end
end
