# encoding: utf-8

FactoryGirl.define do
  factory 'web/report_type' do
    time { Time.now }
    text { "ДТП дорога ДПС засвияже" }
    from { :api }
    longitude { 30.40}
    latitude { 30.40}
    token { generate :string }
  end

  factory 'api/report_type' do
    time { Time.now }
    text { "ДТП дорога ДПС засвияже" }
    from { :api }
    longitude { 30.40}
    latitude { 30.40}
    token { generate :string }
    event_kind { :dtp }
  end
end
