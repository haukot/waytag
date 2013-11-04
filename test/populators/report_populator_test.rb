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
end
