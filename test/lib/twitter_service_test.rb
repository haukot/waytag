# encoding: utf-8

require 'test_helper'

class TwitterServiceTest < ActiveSupport::TestCase
  test "Destroy" do
    report = create :report

    r = stub_request(:post, "https://api.twitter.com/1.1/statuses/destroy/#{report.id_str}.json").
      to_return(:status => 200, :body => "", :headers => {})

    TwitterService.destroy(report)

    assert_requested r
  end

  test "Update" do
    report = create :report

    r = stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json").
      with(:body => {"status" => report.text }).
      to_return(:status => 200, :body => load_fixture('update.json'), :headers => {})

    TwitterService.update(report)

    assert_requested r
  end
end
