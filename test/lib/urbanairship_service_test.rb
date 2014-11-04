# encoding: utf-8

require 'test_helper'
require 'mocha/setup'

class UrbanairshipServiceTest < ActiveSupport::TestCase
  test 'push' do
    create_list :api_user, 100, kind: :android
    report = create :report
    stub_request(:post, %r{ .*?.urbanairship.com/api/push/ })
            .to_return(status: 200, body: '', headers: {})
    UrbanairshipService.push(report)
    assert_requested :post, %r{.*?.urbanairship.com/api/push/}, times: 4
  end
end
