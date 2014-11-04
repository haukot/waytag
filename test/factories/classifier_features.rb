# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classifier_feature, class: 'ClassifierFeature' do
    name { generate :string }
    category { [:good, :bad].sample }
    count { generate :integer }
  end
end
