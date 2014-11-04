# encoding: utf-8

FactoryGirl.define do
  factory :report do
    id_str { generate :integer }
    text { generate :report_text }
    source_text { text }
    time { Time.now }
    source_kind :web
    event_kind { EventKinds.all.sample }
    city
    state { [:posted, :wating_post, :bad, :rejected, :post_failed].sample }

    trait :from_ios do
      source_kind :ios
    end
  end

  factory :report_with_geo, parent: :report do
    latitude { generate :integer }
    longitude { generate :integer }
  end
end
