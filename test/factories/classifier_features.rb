# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classifier_feature, :class => 'ClassifierFeatures' do
    feature "MyString"
    category "MyString"
    count "MyString"
  end
end
