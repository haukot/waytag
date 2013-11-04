# encoding: utf-8

class Classifier
  GOOD = -1
  BAD = 1
  UNKNOWN = 0

  class << self
    def good(text)
      text = clean text

      GreenMidget::Classifier.new(text).classify_as! :ham
    end

    def bad(text)
      text = clean text

      GreenMidget::Classifier.new(text).classify_as! :spam
    end

    def classify(text)
      text = clean text

      GreenMidget::Classifier.new(text).classify
    end

    private

    def clean(text)
      tmp = Mystem.clean text
      text = tmp.join(' ')

      text.gsub(/http:\/\/t.co\/.*\s/, '')
    end
  end
end
