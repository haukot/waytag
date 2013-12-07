# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :web_user do
    ip  { generate :string }
  end
end
