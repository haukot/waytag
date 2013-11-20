class Web::Admin::BonusesController < Web::Admin::ApplicationController
  before_action :set_bonus, except: [:create, :index, :new]

  # GET /bonuses
  def index
    @bonuses = Bonus.all
  end

  # GET /bonuses/new
  def new
    @bonus = Bonus.new
  end

  # GET /bonuses/1/edit
  def edit
  end

  # POST /bonuses
  def create
    @bonus = Bonus.new(bonus_params)

    if @bonus.save
      redirect_to admin_bonuses_path, notice: 'Bonus was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bonuses/1
  def update
    if @bonus.update(bonus_params)
      redirect_to admin_bonuses_path, notice: 'Bonus was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /bonuses/1
  def destroy
    @bonus.destroy
    redirect_to admin_bonuses_url, notice: 'Bonus was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bonus
      @bonus = Bonus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bonus_params
      params.require(:bonus).permit(:title, :description)
    end
end
