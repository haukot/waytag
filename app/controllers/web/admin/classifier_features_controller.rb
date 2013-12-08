class Web::Admin::ClassifierFeaturesController < Web::Admin::ApplicationController
  before_action :set_classifier_feature, except: [:create, :index, :new]

  def index
    query = params[:q] || {}
    @search = ClassifierFeature.ransack query
    @classifier_features = @search.result.page(params[:page]).decorate
  end

  def new
    @classifier_feature = ClassifierFeature.new
  end

  def edit
  end

  def create
    @classifier_feature = ClassifierFeature.new(classifier_feature_params)

    if @classifier_feature.save
      redirect_to admin_classifier_features_path, notice: 'ClassifierFeature was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @classifier_feature.update(classifier_feature_params)
      redirect_to admin_classifier_features_path, notice: 'ClassifierFeature was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @classifier_feature.destroy
    redirect_to admin_classifier_features_url, notice: 'ClassifierFeature was successfully destroyed.'
  end

  private
    def set_classifier_feature
      @classifier_feature = ClassifierFeature.find(params[:id])
    end

    def classifier_feature_params
      params.require(:classifier_feature).permit(:name, :category, :count)
    end
end
