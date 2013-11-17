# encoding: utf-8

require 'test_helper'

class TweetPopulatorTest < ActiveSupport::TestCase
  test "Test populating user and tweet from status params" do
    params = ActiveSupport::JSON.decode(load_fixture('status.json'))
    tp = TweetPopulator.new(params)
    tweet = tp.populate

    assert { tweet.present? }
  end
end
