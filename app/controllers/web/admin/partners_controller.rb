class Web::Admin::PartnersController < Web::Admin::ApplicationController
  before_action :set_partner, except: [:create, :index, :new]

  def index
    query = params[:q] || {}
    @search = Partner.ransack query
    @partners = @search.result.page(params[:page])
  end

  def new
    @partner = Partner.new
  end

  def edit
  end

  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      f(:success)
      redirect_to admin_partners_path
    else
      f(:error)
      render action: 'new'
    end
  end

  def update
    if @partner.update(partner_params)
      f(:success)
      redirect_to admin_partners_path
    else
      f(:error)
      render action: 'edit'
    end
  end

  def destroy
    @partner.destroy
    f(:success)
    redirect_to admin_partners_url
  end

  private

  def set_partner
    @partner = Partner.find(params[:id])
  end

  def partner_params
    params.require(:partner).permit(:title, :description, :city_id)
  end
end
