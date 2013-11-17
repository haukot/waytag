# encoding: utf-8

require 'test_helper'

class ReportPopulatorTest < ActiveSupport::TestCase
  test "Test populating report from Twitter" do
    city = create :city
    tweet = build :tweet

    rp = ReportPopulator.new({
      source_kind: :mentions,
      city_id: city.id
    })

    report = rp.populate_from_twitter tweet

    assert { report.present? }
    assert { report.longitude }
    assert { report.latitude }
    assert { report.sourceable == tweet.twitter_user }
  end

  test "Populating from api report" do
    city = create :city
    api_report = build :api_report

    rp = ReportPopulator.new

    report = rp.populate_from_api(api_report, city)

    assert { report.present? }
    assert { report.longitude.present? }
    assert { report.latitude.present? }
    assert { report.sourceable.present? }
  end

end
