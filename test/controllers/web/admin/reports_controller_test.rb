require 'test_helper'

class Web::Admin::ReportsControllerTest < ActionController::TestCase
  setup do
    @report = create :report
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should destroy report" do
    r = stub_request(:post, "https://api.twitter.com/1.1/statuses/destroy/#{@report.id_str}.json").
      to_return(:status => 200, :body => "", :headers => {})

    delete :destroy, id: @report

    assert_redirected_to admin_reports_path
  end
end
