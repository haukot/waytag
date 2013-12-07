# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory 'city/street' do
    name
    rate { generate :integer }
    city
  end
end
