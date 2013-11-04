# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twitter_user do
    profile_image_url { generate :slug }
    name
    screen_name { generate :name }
    id_str { generate :slug }
  end
end
