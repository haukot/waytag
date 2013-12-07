require 'test_helper'

class Web::Cities::DashboardControllerTest < ActionController::TestCase
  setup do
    @city = create :city
  end

  test "should get show" do
    get :show, city_id: @city.id
    assert_response :success
  end
end
