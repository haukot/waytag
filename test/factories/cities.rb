# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    slug { generate :subdomain }
    name
    email
    twitter_name { generate :login }
    hashtag { generate :login }
  end
end
