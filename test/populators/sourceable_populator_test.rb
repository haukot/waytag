# encoding: utf-8

require 'test_helper'

class SourceablePopulatorTest < ActiveSupport::TestCase

  test "Test populating ios user" do
    sp = SourceablePopulator.new({
      type: :ios,
      token: generate(:string)
    })
    user = sp.populate

    assert { user.kind_of?(IosUser) }
  end

  test "Test populating android user" do
    sp = SourceablePopulator.new({
      type: :android,
      token: generate(:string)
    })
    user = sp.populate

    assert { user.kind_of?(AndroidUser) }
  end

  test "Test populating api user" do
    sp = SourceablePopulator.new({
      type: :api,
      token: generate(:string)
    })
    user = sp.populate

    assert { user.kind_of?(ApiUser) }
  end

end
