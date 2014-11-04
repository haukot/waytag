require 'test_helper'

class Api::Cities::StreetsControllerTest < ActionController::TestCase
  def setup
    @street = create 'city/street'
  end

  test 'should get index' do
    get :index, city_id: @street.city.id, format: :json

    assert_response :success
  end
end
