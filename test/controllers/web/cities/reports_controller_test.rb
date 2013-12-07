require 'test_helper'

class Web::Cities::ReportsControllerTest < ActionController::TestCase
  setup do
    @city = create :city
  end

  test "should create report" do
    ReportsWorker.jobs.clear
    assert_equal 0, ReportsWorker.jobs.size

    attrs = attributes_for :report
    post :create, city_id: @city.id, api_report: { text: attrs[:source_text], time: Time.now, event_kind: attrs[:event_kind] }

    assert_response :created

    assert_equal 1, ReportsWorker.jobs.size
  end

end
