require 'test_helper'

class Web::Admin::PartnersControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: '8xx8ru'
    sign_in user

    @partner = create :partner
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:partners)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create partner' do
    post :create, partner: { description: @partner.description, title: @partner.title }

    assert_redirected_to admin_partners_path
  end

  test 'should get edit' do
    get :edit, id: @partner
    assert_response :success
  end

  test 'should update partner' do
    patch :update, id: @partner, partner: { description: @partner.description, title: @partner.title }
    assert_redirected_to admin_partners_path
  end

  test 'should destroy partner' do
    delete :destroy, id: @partner

    assert_redirected_to admin_partners_path
  end
end
