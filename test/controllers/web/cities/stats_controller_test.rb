require 'test_helper'

class Web::Cities::StatsControllerTest < ActionController::TestCase
  setup do
    @city = create :city
    create :report, city: @city
  end

  test "should get index" do
    get :index, city_id: @city.id
    assert_response :success
  end

end
