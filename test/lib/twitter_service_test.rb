# encoding: utf-8

require 'test_helper'
require "mocha/setup"

class TwitterServiceTest < ActiveSupport::TestCase
  test "populate user" do
    stub_request(:get, "https://api.twitter.com/1.1/users/show.json").with(:query => {:screen_name => "sferik"}).to_return(:body => load_fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    user = TwitterService.populate_user "sferik"
    assert { user.valid? }
  end

  test "Destroy" do
    report = create :report

    r = stub_request(:post, "https://api.twitter.com/1.1/statuses/destroy/#{report.id_str}.json").
      to_return(:body => load_fixture("status.json"), :headers => {:content_type => "application/json; charset=utf-8"})

    TwitterService.destroy(report)

    assert_requested r
  end

  test "Update" do
    report = create :report

    r = stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json").
      with(:body => {"status" => report.decorate.composed_text }).
      to_return(:status => 200, :body => load_fixture('update.json'), :headers => {})

    TwitterService.update(report)

    assert_requested r
  end

  test "Update with picture" do
    #TwitterService.expects(:image).returns("map-data")
    #report = create :report_with_geo


    #r = stub_request(:post, "https://api.twitter.com/1.1/statuses/update_with_media.json").
    #  with(:body => { "media"=>["map-data"], "status" => report.text }).
    #  to_return(:status => 200, :body => load_fixture('update.json'), :headers => {})

    #TwitterService.update(report)

    #assert_requested r
  end

end
