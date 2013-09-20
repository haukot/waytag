# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ios_user do
    token { generate :slug }
  end
end
