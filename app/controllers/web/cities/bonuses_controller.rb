class Web::Cities::BonusesController < Web::Cities::ApplicationController
  # GET /bonuses
  def index
    @bonuses = resource_city.bonuses
  end

  # GET /bonuses/1
  def show
    @bonus = resource_city.bonuses.find(params[:id])
  end
end
