#encoding: utf-8
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@city.twitter_name} - Дорожная обстановка в г. #{@city.name}"
    xml.description "Waytag.ru - Дорожная обстановка в вашем городе"
    xml.link rss_url @city

    for message in @messages
      xml.item do
        xml.title message.text_with_date
        xml.description ""
        xml.pubDate message.created_at.to_s(:rfc822)
      end
    end
  end
end
