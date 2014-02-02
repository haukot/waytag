# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_user do
    token  { generate :slug }
    push_token  { generate :token }
    kind  { :api }
  end
end
