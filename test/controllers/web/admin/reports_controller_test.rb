require 'test_helper'

class Web::Admin::ReportsControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: "8xx8ru"
    sign_in user

    @report = create :report
  end

  test "should patch perform" do
    report = create :report, state: :added

    patch :perform, id: report
    assert_response :redirect
  end

  test "should patch good" do
    patch :good, id: @report
    assert_response :redirect
  end

  test "should patch bad" do
    patch :bad, id: @report
    assert_response :redirect
  end

  test "should patch publish" do
    PostWorker.jobs.clear
    assert_equal 0, PostWorker.jobs.size

    patch :publish, id: @report
    assert_response :redirect

    assert_equal 1, PostWorker.jobs.size
  end

  test "should get index" do
    create :report, state: :rejected, event_kind: :prbk
    create :report, state: :bad, event_kind: :dtp
    create :report, state: :post_failed
    create :report, state: :posted, event_kind: :cmr
    create :report, state: :deleted, event_kind: :dps
    create :report, state: :wating_post

    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should destroy report" do
    r = stub_request(:post, "https://api.twitter.com/1.1/statuses/destroy/#{@report.id_str}.json").
      to_return(:body => load_fixture("status.json"), :headers => {:content_type => "application/json; charset=utf-8"})

    delete :destroy, id: @report

    assert_redirected_to admin_reports_path
  end
end
