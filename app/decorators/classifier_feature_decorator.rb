class ClassifierFeatureDecorator < Draper::Decorator
  delegate_all

  def category_class
    if object.category.good?
      "label-success"
    else
      "label-danger"
    end
  end

end
