# encoding: utf-8

FactoryGirl.define do
  factory :api_report do
    time { Time.now }
    text { "ДТП дорога ДПС засвияже" }
    type { :api }
    longitude { 30.40}
    latitude { 30.40}
    token { generate :string }
  end
end
