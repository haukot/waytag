require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @report = create :report
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report" do
    post :create, report: { city_id: @report.city_id, source_type: @report.source_type, state: @report.state, text: @report.text, time: @report.time }

    assert_redirected_to report_path(assigns(:report))
  end

  test "should show report" do
    get :show, id: @report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report
    assert_response :success
  end

  test "should update report" do
    patch :update, id: @report, report: { city_id: @report.city_id, @report.source_kind, source_type: @report.source_type, state: @report.state, text: @report.text, time: @report.time }
    assert_redirected_to report_path(assigns(:report))
  end

  test "should destroy report" do
    delete :destroy, id: @report

    assert_redirected_to reports_path
  end
end
