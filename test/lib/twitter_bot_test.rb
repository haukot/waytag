# encoding: utf-8

require 'test_helper'

class TwitterBotTest < ActiveSupport::TestCase
  setup do
  end

  test "handle_status_i_love" do
    r = stub_request(:post, "https://api.twitter.com/1.1/direct_messages/new.json").
      with(:body => {"text"=>"I love you tooo!", "user_id"=>"216778941"}).
      to_return(:status => 200, :body => "", :headers => {})

    TwitterBot.handle_status(load_fixture('status_i_love.json'), 'ul', 'hashtag')

    assert_requested r
  end

  test "handle_status_repost" do
    ReportsWorker.jobs.clear
    assert_equal 0, ReportsWorker.jobs.size

    TwitterBot.handle_status(load_fixture('status.json'), 'ul', 'hashtag')

    assert_equal 1, ReportsWorker.jobs.size
  end

end
