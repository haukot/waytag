# encoding: utf-8

require 'test_helper'
require "mocha/setup"

class UrbanairshipServiceTest < ActiveSupport::TestCase
  test "push" do
    create_list :android_user, 100
    report = create :report
    request = stub_request(:post, /.*?.urbanairship.com\/api\/push\//).
            to_return(:status => 200, :body => "", :headers => {})
    UrbanairshipService.push(report)
    assert_requested :post, /.*?.urbanairship.com\/api\/push\//, times: 4
  end

end
