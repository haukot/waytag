# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vk_user do
    name
    vk_id { generate :slug }
  end
end
