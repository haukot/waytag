class Web::Admin::PartnersController < Web::Admin::ApplicationController
  before_action :set_partner, except: [:create, :index, :new]

  # GET /partners
  def index
    @partners = Partner.all
  end

  # GET /partners/new
  def new
    @partner = Partner.new
  end

  # GET /partners/1/edit
  def edit
  end

  # POST /partners
  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      redirect_to admin_partner_path(@partner), notice: 'Partner was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /partners/1
  def update
    if @partner.update(partner_params)
      redirect_to admin_partner_path(@partner), notice: 'Partner was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /partners/1
  def destroy
    @partner.destroy
    redirect_to admin_partners_url, notice: 'Partner was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      @partner = Partner.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def partner_params
      params.require(:partner).permit(:title, :description)
    end
end
