class Web::Cities::BonusesController < Web::Cities::ApplicationController
  # GET /bonuses
  def index
    query = params[:q] || {}
    @search = resource_city.bonuses.ransack query
    @bonuses = @search.result.page(params[:page])

  end

end
