class Web::ClassifiersController < Web::ApplicationController

  def show
    @classifier_meta = Classifier.meta_classify('the quick brown dox jumps')
  end

end
