require 'test_helper'

class Rss::MessagesControllerTest < ActionController::TestCase
  def setup
    @report = create :report
    @city = @report.city
  end

  test "should get feed" do
    get :feed, { id: @city.slug }
    assert_response :success
  end
end
