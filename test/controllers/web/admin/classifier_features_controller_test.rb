require 'test_helper'

class Web::Admin::ClassifierFeaturesControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: "8xx8ru"
    sign_in user

    @classifier_feature = create :classifier_feature
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classifier_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create classifier_feature" do
    attrs = attributes_for :classifier_feature
    post :create, classifier_feature: attrs

    assert_redirected_to admin_classifier_features_path
  end

  test "should get edit" do
    get :edit, id: @classifier_feature
    assert_response :success
  end

  test "should update classifier_feature" do
    patch :update, id: @classifier_feature, classifier_feature: { name: generate(:string) }
    assert_redirected_to admin_classifier_features_path
  end

  test "should destroy classifier_feature" do
    delete :destroy, id: @classifier_feature

    assert_redirected_to admin_classifier_features_path
  end
end
