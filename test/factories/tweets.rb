# encoding: utf-8

FactoryGirl.define do
  factory :tweet do
    id_str { generate :slug }
    twitter_user
    text { 'ДТП дорога ДПС засвияже' }
    created_at { Time.now }
    in_reply_to_status_id_str { nil }
    in_reply_to_user_id_str { nil }
    longitude { 30.40 }
    latitude { 30.40 }
    retweeted { false }
  end
end
