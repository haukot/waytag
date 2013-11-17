# encoding: utf-8

require 'test_helper'

class Api::Cities::ReportsControllerTest < ActionController::TestCase
  def setup
    @city = create :city
  end

  test "should get index" do
    get :index, city_id: @city.id, format: :json
    assert_response :success
  end

  test "should post create" do
    ReportsWorker.jobs.clear
    assert_equal 0, ReportsWorker.jobs.size
    attrs = attributes_for :api_report

    post :create, city_id: @city.id, report: attrs, format: :json

    assert_response :created
    assert_equal 1, ReportsWorker.jobs.size
  end
end
