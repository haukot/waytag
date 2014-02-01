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
    attrs = attributes_for 'api/report_type'

    post :create, city_id: @city.id, report: attrs, format: :json

    assert_response :created
    assert_equal 1, ReportsWorker.jobs.size
  end

  test "should not post create for blocked user" do
    user = create :api_user, state: :blocked
    attrs = attributes_for 'api/report_type', type: :api, token: user.token

    post :create, city_id: @city.id, report: attrs, format: :json

    assert_response :forbidden
  end

  test "should post create from Andrushya width geo and aempty text" do
    ReportsWorker.jobs.clear

    attrs = {
      latitude: 54.316157,
      longitude: 48.395595,
      event_kind: :dtp,
      push_token: generate(:token),
      token: generate(:token),
      from: :android
    }

    post :create, city_id: @city.id, report: attrs, format: :json

    assert_response :created
    assert { ReportsWorker.jobs.size == 1}

    user = AndroidUser.first
    assert { user != nil }
    assert { user.token == attrs[:token] }
    assert { user.push_token == attrs[:push_token] }
  end


end
