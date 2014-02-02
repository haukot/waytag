require 'test_helper'

class Rss::MessagesControllerTest < ActionController::TestCase
  def setup
    @city = create :city
    @report = create_list :report, 20, city: @city
  end

  test "should get feed" do
    get :feed, { id: @city.slug, ololo_yeah!: true }
    assert_response :success
  end
end
