require 'test_helper'

class Web::Cities::DashboardControllerTest < ActionController::TestCase
  setup do
    @city = create :city
  end

  test 'should get show' do
    create :report, sourceable: create(:api_user), source_kind: :api
    create :report, sourceable: create(:vk_user), source_kind: :vk
    create :report, sourceable: create(:twitter_user), source_kind: :mentions
    create :report, sourceable: create(:web_user), source_kind: :web
    create :report_with_geo

    get :show, city_id: @city.id
    assert_response :success
  end
end
