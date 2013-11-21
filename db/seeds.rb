# encoding: utf-8

ul = City.find_or_create_by name: "Ульяновск", twitter_name: "@Ulway", email: "ul@waytag.ru", slug: "ul", hashtag: "ulway"

City.find_or_create_by name: "Чебоксары", twitter_name: "@Chebway", email: "cheb@waytag.ru", slug: "cheb", hashtag: "chebway"

City.find_or_create_by name: "Пермь", twitter_name: "@Perm_way", email: "perm@waytag.ru", slug: "perm", hashtag: "permway"

City.find_or_create_by name: "Екатеринбург", twitter_name: "@Ekbway", email: "ekbway@waytag.ru", slug: "ekb", hashtag: "ekbway"

City.find_each do |city|
  if city.streets.any?
    YAML.load_file( "db/streets-#{city.slug}.yml" ).each do |street|
      ul.streets.find_or_create_by( name: street["name"].downcase, rate: street["rate"] )
    end
  end

  user = TwitterService.populate_user city.twitter_name.gsub(/@/, '')
  user.deactivate
end

if Rails.env.development?
  FactoryGirl.reload
  FactoryGirlSequences.reload

  user = TwitterService.populate_user "vdv73rus"
  FactoryGirl.create_list :report, 5, sourceable: user, city: ul, source_kind: :mentions

  user = TwitterService.populate_user "8xx8ru"
  FactoryGirl.create_list :report, 5, sourceable: user, city: ul, source_kind: :hashtag

  user = FactoryGirl.create_list :ios_user, 26
  FactoryGirl.create_list :report, 5, sourceable: user.first, city: ul, source_kind: :ios

  user = FactoryGirl.create_list :api_user, 26
  FactoryGirl.create_list :report, 5, sourceable: user.first, city: ul, source_kind: :api

  user = FactoryGirl.create_list :android_user, 26
  FactoryGirl.create_list :report, 5, sourceable: user.first, city: ul, source_kind: :android

  FactoryGirl.create_list :post, 26
  FactoryGirl.create_list :bonus, 26, city: ul
  FactoryGirl.create_list :partner, 26, city: ul

  Report.find_each do |report|
    report.text = TextComposer.compose(report)
    report.time = Time.now + rand(5).hours + rand(60).minutes
    report.save
  end
end
