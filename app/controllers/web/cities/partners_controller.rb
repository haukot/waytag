class Web::Cities::PartnersController < Web::Cities::ApplicationController
  # GET /partners
  def index
    query = { 's' => 'created_at desc' }.merge(params[:q] || {})
    @search = resource_city.partners.ransack query
    @partners = @search.result.page(params[:page])
  end

  # GET /partners/1
  def show
    @partner = resource_city.partners.find(params[:id])
  end
end
