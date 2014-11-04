class Web::Admin::BonusesController < Web::Admin::ApplicationController
  before_action :set_bonus, except: [:create, :index, :new]

  def index
    query = params[:q] || {}
    @search = Bonus.ransack query
    @bonuses = @search.result.page(params[:page])
  end

  def new
    @bonus = Bonus.new
  end

  def edit
  end

  def create
    @bonus = Bonus.new(bonus_params)

    if @bonus.save
      f(:success)
      redirect_to admin_bonuses_path
    else
      f(:error)
      render action: 'new'
    end
  end

  def update
    if @bonus.update(bonus_params)
      f(:success)
      redirect_to admin_bonuses_path
    else
      f(:error)
      render action: 'edit'
    end
  end

  def destroy
    @bonus.destroy

    f(:success)
    redirect_to admin_bonuses_url
  end

  private

  def set_bonus
    @bonus = Bonus.find(params[:id])
  end

  def bonus_params
    params.require(:bonus).permit(:title, :description, :city_id)
  end
end
