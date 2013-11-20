class Web::Admin::CitiesController < Web::Admin::ApplicationController
  before_action :set_city, except: [:create, :index, :new]

  # GET /cities
  def index
    @cities = City.all
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to admin_cities_path, notice: 'City was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /cities/1
  def update
    if @city.update(city_params)
      redirect_to admin_cities_path, notice: 'City was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /cities/1
  def destroy
    @city.destroy
    redirect_to admin_cities_url, notice: 'City was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def city_params
      params.require(:city).permit(:slug, :name, :email, :twitter_name, :hashtag)
    end
end
