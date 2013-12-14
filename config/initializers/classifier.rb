Classifier = FisherClassifier.create do
  assumed_prob 0.2
  fisher_threshold 0.211111

  inc_feature do |feature, category|
    feature = ClassifierFeature.find_or_initialize_by(name: feature, category: category)

    feature.count += 1 if feature

    feature.save
  end

  inc_category do; end

  get_features do |text|
    text = text.gsub(/http:\/\/\s*?/, '')
    features = Mystem.clean text
    features.uniq
    features = features.select { |f| f.size > 2 }
    features = features.map { |f| f.mb_chars.downcase.strip }
    features << "count_#{features.count}"
  end

  categories do
    ClassifierFeature.category.values
  end

  category_count do |category|
    ClassifierFeature.where(category: category).count
  end

  features_count do |feature, category|
    f = ClassifierFeature.find_by(name: feature, category: category)
    if f
      f.count
    else
      0
    end
  end

  default_category do
    "bad"
  end
end
