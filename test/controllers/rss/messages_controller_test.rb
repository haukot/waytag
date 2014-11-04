require 'test_helper'

class Rss::MessagesControllerTest < ActionController::TestCase
  def setup
    @city = create :city
    @report = create_list :report, 20, city: @city
  end

  test 'should get feed' do
    get :feed, id: @city.slug, token:  'jbyeOOwmpPhTvo7LETJVc3MwgiLYMJS3mvYxZMKC5TgNhteodtH2MBC5ugKBBC6B'
    assert_response :success
  end
end
