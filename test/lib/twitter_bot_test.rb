# encoding: utf-8

require 'test_helper'

class TwitterBotTest < ActiveSupport::TestCase
  setup do
    create :city
  end

  test 'handle_status_i_love' do
    r = stub_request(:post, 'https://api.twitter.com/1.1/direct_messages/new.json')
      .with(body: { 'text' => 'I love you tooo!', 'user_id' => '216778941' })
      .to_return(status: 200, body: load_fixture('direct_message.json'), headers: { content_type: 'application/json; charset=utf-8' })

    TwitterBot.handle_status(load_fixture('status_i_love.json'))

    assert_requested r
  end

  test 'Should repost status' do
    ReportsWorker.jobs.clear
    assert_equal 0, ReportsWorker.jobs.size

    TwitterBot.handle_status(load_fixture('status_ulway.json'))

    assert_equal 1, ReportsWorker.jobs.size
  end

  test 'Should not repost status without city' do
    ReportsWorker.jobs.clear
    assert_equal 0, ReportsWorker.jobs.size

    TwitterBot.handle_status(load_fixture('status.json'))

    assert_equal 0, ReportsWorker.jobs.size
  end

  test 'Should not repost status from blocked twitter user' do
    create :twitter_user, screen_name: '8xx8ru', uid: '216778941', state: :blocked
    ReportsWorker.jobs.clear
    assert_equal 0, ReportsWorker.jobs.size

    TwitterBot.handle_status(load_fixture('status_from_blocked.json'))

    assert_equal 0, ReportsWorker.jobs.size
  end

  # test "Answer on yell" do
  # r = stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json")
  # .to_return(:status => 200, :body => load_fixture("status.json"), :headers => {:content_type => "application/json; charset=utf-8"})

  # TwitterBot.handle_status(load_fixture('status_yell.json'), 'ul', 'hashtag')

  # assert_requested r
  # end

  # test "Answer on question" do
  # r = stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json")
  # .to_return(:status => 200, :body => load_fixture("status.json"), :headers => {:content_type => "application/json; charset=utf-8"})

  # TwitterBot.handle_status(load_fixture('status_question.json'), 'ul', 'hashtag')

  # assert_requested r
  # end
end
