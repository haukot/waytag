# encoding: utf-8

require 'test_helper'

class TwitterUserPopulatorTest < ActiveSupport::TestCase
  test "Test populating user and tweet from status params" do
    params = ActiveSupport::JSON.decode(load_fixture('status.json'))
    tup = TwitterUserPopulator.new(params["user"])

    user = tup.populate

    assert { user.present? }
  end
end
