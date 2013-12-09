class Web::Admin::CitiesController < Web::Admin::ApplicationController
  before_action :set_city, except: [:create, :index, :new]

  def index
    query = params[:q] || {}
    @search = City.ransack query
    @cities = @search.result.page(params[:page])
  end

  def new
    @city = City.new
  end

  def edit
  end

  def create
    @city = City.new(city_params)

    if @city.save
      f(:success)
      redirect_to admin_cities_path
    else
      f(:error)
      render action: 'new'
    end
  end

  # PATCH/PUT /cities/1
  def update
    if @city.update(city_params)
      f(:success)
      redirect_to admin_cities_path
    else
      f(:error)
      render action: 'edit'
    end
  end

  # DELETE /cities/1
  def destroy
    @city.destroy
    f(:success)
    redirect_to admin_cities_url
  end

  private
    def set_city
      @city = City.friendly.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:slug, :name, :email, :twitter_name, :hashtag)
    end
end
