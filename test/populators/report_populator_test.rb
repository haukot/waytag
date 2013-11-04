# encoding: utf-8

require 'test_helper'

class ReportPopulatorTest < ActiveSupport::TestCase
  test "Test populating report from Twitter" do
    city = create :city
    tweet = create :tweet, report: nil

    rp = ReportPopulator.new({
      source_kind: :mentions,
      city_id: city.id
    })

    report = rp.create_from_tweet tweet

    assert { report.present? }
    assert { report.longitude }
    assert { report.latitude }
    assert { report.sourceable.id == tweet.id }
  end
end
