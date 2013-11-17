require 'test_helper'

class Api::CitiesControllerTest < ActionController::TestCase
  def setup
    @city = create_list :city, 11
  end

  test "should get index" do
    get :index, { format: :json }

    assert_response :success
  end

end
