require 'test_helper'

class Web::Cities::BonusesControllerTest < ActionController::TestCase
  setup do
    @city = create :city
    @bonus = create :bonus, city: @city
  end

  test "should get index" do
    get :index, city_id: @city.id
    assert_response :success
    assert_not_nil assigns(:bonuses)
  end

  test "should get show" do
    get :show, id: @bonus, city_id: @city.id
    assert_response :success
  end
end
