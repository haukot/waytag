class Web::Admin::StreetsController < Web::Admin::ApplicationController
  before_action :set_city_street, except: [:create, :index, :new]

  # GET /city_streets
  def index
    query = params[:q] || {}
    @search = City::Street.ransack query
    @city_streets = @search.result.page(params[:page])
  end

  # GET /city_streets/new
  def new
    @city_street = City::Street.new
  end

  # GET /city_streets/1/edit
  def edit
  end

  # POST /city_streets
  def create
    @city_street = City::Street.new(city_street_params)

    if @city_street.save
      redirect_to admin_streets_path, notice: 'City::Street was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /city_streets/1
  def update
    if @city_street.update(city_street_params)
      redirect_to admin_streets_path, notice: 'City::Street was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /city_streets/1
  def destroy
    @city_street.destroy
    redirect_to admin_streets_url, notice: 'City::Street was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city_street
      @city_street = City::Street.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def city_street_params
      params.require(:city_street).permit(:name, :city_id)
    end
end
