class Web::Cities::PartnersController < Web::Cities::ApplicationController
  # GET /partners
  def index
    @partners = resource_city.partners
  end

  # GET /partners/1
  def show
    @partner = resource_city.partners.find(params[:id])
  end
end
