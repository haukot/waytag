class Web::Admin::TweetsController < Web::Admin::ApplicationController
  # GET /tweets
  def index
    @tweets = Tweet.all
  end
end
