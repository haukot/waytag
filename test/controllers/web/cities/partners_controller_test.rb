require 'test_helper'

class Web::Cities::PartnersControllerTest < ActionController::TestCase
  setup do
    @city = create :city
    @partner = create :partner, city_id: @city.id
  end

  test 'should get index' do
    get :index, city_id: @city.id
    assert_response :success
    assert_not_nil assigns(:partners)
  end

  test 'should get edit' do
    get :show, id: @partner.id, city_id: @city.id
    assert_response :success
  end
end
