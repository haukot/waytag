# encoding: utf-8

require 'test_helper'

class ClassifierTest < ActiveSupport::TestCase
  setup do
    load_fixture('good_texts') do |line|
      Classifier.train(line, :good)
    end

    load_fixture('bad_texts').each_line do |line|
      Classifier.train(line, :bad)
    end
  end

  test "CLassif" do
    load_fixture('good_texts') do |line|
      assert do
        Classifier.classify(line).to_sym == :good
      end
    end

    load_fixture('bad_texts').each_line do |line|
      assert do
        Classifier.classify(line).to_sym == :bad
      end
    end
  end

end
