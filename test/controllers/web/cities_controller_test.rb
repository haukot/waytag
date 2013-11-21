require 'test_helper'

class Web::CitiesControllerTest < ActionController::TestCase
  setup do
    create_list :city, 5
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
