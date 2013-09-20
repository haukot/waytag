# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_user do
    token  { generate :slug }
  end
end
