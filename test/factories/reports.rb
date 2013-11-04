# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    id_str { generate :string }
    text { generate :body }
    source_text { generate :body }
    time { Time.now }
    source_kind :web
    city

    trait :from_ios do
      source_kind :ios
    end
  end

  factory :report_with_geo, parent: :report do
    latitude { generate :integer }
    longitude { generate :integer }
  end
end
