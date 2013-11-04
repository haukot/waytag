# encoding: utf-8
require 'test_helper'

class ReportsServiceTest < MiniTest::Unit::TestCase
  def setup
    @text = "На Локомотивной 67 дежурит отряд ДПС. Соблюдайте скоростной режим."

    Classifier.good @text
    Classifier.good @text
    Classifier.good @text
    Classifier.bad "ololo"
  end


  def test_perform
    assert_equal 0, PostWorker.jobs.size

    report = FactoryGirl.create :report, text: "", source_text: @text
    ReportsService.perform(report.id)

    assert_equal 1, PostWorker.jobs.size
  end

end
