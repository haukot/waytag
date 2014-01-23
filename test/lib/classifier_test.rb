# encoding: utf-8

require 'test_helper'

class ClassifierTest < ActiveSupport::TestCase
  DEPTH = 4

  setup do
    @good = File.readlines(File.expand_path("../../../db/tweets/bad", __FILE__))
    @bad = File.readlines(File.expand_path("../../../db/tweets/good", __FILE__))

    @count = [@good.count, @bad.count].min
    #load_fixture('good_texts') do |line|
      #Classifier.train(line, :good)
    #end

    #load_fixture('bad_texts').each_line do |line|
      #Classifier.train(line, :bad)
    #end
    @results = []
  end

  test "Classifier test" do
#    generate_cases(0, @count)
#    p @results.inject(0){ |sum, e| sum + e } / @results.size
  end

  def generate_cases(b, e, depth = 1)
    if depth < DEPTH
      generate_cases(b, middle(b, e), depth + 1)
      generate_cases(middle(b, e), e, depth + 1)
    else
      run_case(b, e)
    end
  end

  def run_case(b, e)
    train(b, middle(b, e))
    @results << check(middle(b, e), e)
    ClassifierFeature.delete_all
  end

  def train(b, e)
    print "t"
    (b..e).each do |k|
      Classifier.train(@good[k], :good)
      Classifier.train(@bad[k], :bad)
      print "."
    end
  end

  def check(b, e)
    print "c"
    right = 0
    wrong = 0

    (b..e).each do |k|
      print "."
      if Classifier.classify(@good[k]).to_sym == :good
        right += 1
      else
        wrong += 1
      end

      if Classifier.classify(@bad[k]).to_sym == :bad
        right += 1
      else
        wrong += 1
      end
    end

    wrong / (right + wrong).to_f
  end

  def middle(beginning, ending)
    middle = beginning + (ending - beginning) / 2
  end
end
