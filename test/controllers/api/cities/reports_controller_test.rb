# encoding: utf-8

require 'test_helper'

class Api::Cities::ReportsControllerTest < ActionController::TestCase
  def setup
    @city = create :city
    @user = create :api_user
  end

  test "should get index" do
    create_list :report, 5, city_id: @city.id

    get :index, city_id: @city.id, format: :json
    assert_response :success
  end

  test "should post create" do
    ReportsWorker.jobs.clear
    attrs = {
      text: generate(:report_text),
      event_kind: :dtp
    }

    post :create, city_id: @city.id, report: attrs, token: @user.token, format: :json

    assert_response :created
    assert_equal 1, ReportsWorker.jobs.size
  end

  test "should not post create for blocked user" do
    @user.deactivate
    attrs = attributes_for 'api/report_type'

    assert do
      rescuing {
        post :create, city_id: @city.id, report: attrs, token: @user.token, format: :json
      }.kind_of? ApplicationController::Forbidden
    end
  end

  test "should post create from Andrushya width geo and empty text" do
    ReportsWorker.jobs.clear

    attrs = {
      latitude: 54.316157,
      longitude: 48.395595,
      event_kind: :dtp
    }

    post :create, city_id: @city.id, report: attrs, token: @user.token, format: :json

    assert_response :created
    assert { ReportsWorker.jobs.size == 1}
  end


end
