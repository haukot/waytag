# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory 'city/street' do
    name { generate :string }
    rate { generate :integer }
    city
  end
end
