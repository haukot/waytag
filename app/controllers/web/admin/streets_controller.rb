class Web::Admin::StreetsController < Web::Admin::ApplicationController
  before_action :set_city_street, except: [:create, :index, :new]

  def index
    query = params[:q] || {}
    @search = City::Street.ransack query
    @city_streets = @search.result.page(params[:page])
  end

  def new
    @city_street = City::Street.new
  end

  def edit
  end

  def create
    @city_street = City::Street.new(city_street_params)

    if @city_street.save
      f(:success)
      redirect_to admin_streets_path
    else
      f(:error)
      render action: 'new'
    end
  end

  def update
    if @city_street.update(city_street_params)
      f(:success)
      redirect_to admin_streets_path
    else
      f(:error)
      render action: 'edit'
    end
  end

  def destroy
    @city_street.destroy
    f(:success)
    redirect_to admin_streets_url
  end

  private

  def set_city_street
    @city_street = City::Street.find(params[:id])
  end

  def city_street_params
    params.require(:city_street).permit(:name, :city_id)
  end
end
