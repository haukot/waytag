class Web::CitiesController < Web::ApplicationController

  def index
    @cities = City.all
  end

end
