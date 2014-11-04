class Web::ClassifiersController < Web::ApplicationController
  def show
    text = params[:text]
    text ||= Report.latest_posted.first.source_text
    @classifier_meta = Classifier.meta_classify(text)
  end
end
