# encoding: utf-8

FactoryGirl.define do
  factory :city do
    initialize_with { City.find_or_create_by(slug: "ul") }
    name { "Ульяновск" }
    email
    twitter_name { "@Ulway" }
    hashtag { "ulway" }
  end
end
