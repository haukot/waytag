# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twitter_user do
    image { generate :slug }
    name
    screen_name { generate :name }
    external_id_str { generate :slug }
  end
end
