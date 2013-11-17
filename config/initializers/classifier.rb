Classifier = FisherClassifier.create do

  inc_feature do |feature, category|
    feature = ClassifierFeatures.find_or_initialize_by(name: feature, category: category)

    feature.count += 1 if feature

    feature.save
  end

  inc_category do; end

  get_features do |text|
    text = text.gsub(/http:\/\/\s*?/, '')
    features = Mystem.clean text
    features.uniq
    features = features.select { |f| f.size > 2 }
  end

  categories do
    ClassifierFeatures.category.values
  end

  category_count do |category|
    ClassifierFeatures.where(category: category).sum(:count)
  end

  features_count do |feature, category|
    f = ClassifierFeatures.find_by(name: feature, category: category)
    if f
      f.count
    else
      0
    end
  end

  default_category do
    :none
  end
end
