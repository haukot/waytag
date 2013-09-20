require 'test_helper'

class BonusesControllerTest < ActionController::TestCase
  setup do
    @bonus = create :bonus
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bonuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bonus" do
    assert_difference('Bonus.count') do
      post :create, bonus: { description: @bonus.description, title: @bonus.title }
    end

    assert_redirected_to bonus_path(assigns(:bonus))
  end

  test "should show bonus" do
    get :show, id: @bonus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bonus
    assert_response :success
  end

  test "should update bonus" do
    patch :update, id: @bonus, bonus: { description: @bonus.description, title: @bonus.title }
    assert_redirected_to bonus_path(assigns(:bonus))
  end

  test "should destroy bonus" do
    assert_difference('Bonus.count', -1) do
      delete :destroy, id: @bonus
    end

    assert_redirected_to bonuses_path
  end
end
