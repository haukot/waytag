require 'test_helper'

class Web::Admin::BonusesControllerTest < ActionController::TestCase
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
    post :create, bonus: { description: @bonus.description, title: @bonus.title }

    assert_redirected_to admin_bonus_path(assigns(:bonus))
  end

  test "should get edit" do
    get :edit, id: @bonus
    assert_response :success
  end

  test "should update bonus" do
    patch :update, id: @bonus, bonus: { description: @bonus.description, title: @bonus.title }
    assert_redirected_to admin_bonus_path(assigns(:bonus))
  end

  test "should destroy bonus" do
    delete :destroy, id: @bonus

    assert_redirected_to admin_bonuses_path
  end
end
