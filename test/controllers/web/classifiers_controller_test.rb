require 'test_helper'

class Web::ClassifiersControllerTest < ActionController::TestCase
  setup do
    create_list :report, 5, state: :posted
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
