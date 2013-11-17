# encoding: utf-8
#User.find_or_create_by_login "admin", password: "admin"

ul = City.find_or_create_by name: "Ульяновск", twitter_name: "@ulway", email: "ul@waytag.ru", slug: "ul", hashtag: "ulway"

YAML.load_file( 'db/streets-ul.yml' ).each do |street|
  City::Street.where(city_id: ul.id, name: street["name"].downcase, rate: street["rate"]).first_or_create
end

cheb = City.find_or_create_by name: "Чебоксары", twitter_name: "@chebway", email: "cheb@waytag.ru", slug: "cheb", hashtag: "chebway"

YAML.load_file( 'db/streets-cheb.yml' ).each do |street|
  City::Street.where(city_id: cheb.id, name: street["name"].downcase, rate: street["rate"]).first_or_create
end

perm = City.find_or_create_by name: "Пермь", twitter_name: "@Perm_way", email: "perm@waytag.ru", slug: "perm", hashtag: "permway"

YAML.load_file( 'db/streets-perm.yml' ).each do |street|
  City::Street.where(city_id: perm.id, name: street["name"].downcase, rate: street["rate"]).first_or_create
end

ekb = City.find_or_create_by name: "Екатеринбург", twitter_name: "@Ekbway", email: "ekbway@waytag.ru", slug: "ekb", hashtag: "ekbway"

YAML.load_file( 'db/streets-ekb.yml' ).each do |street|
  City::Street.where(city_id: ekb.id, name: street["name"].downcase, rate: street["rate"]).first_or_create
end
