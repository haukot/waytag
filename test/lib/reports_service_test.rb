# encoding: utf-8
require 'test_helper'

class ReportsServiceTest < ActiveSupport::TestCase

  setup do
    @text = "На Локомотивной 67 дежурит отряд ДПС. Соблюдайте скоростной режим."

    Classifier.train(@text, :good)
    Classifier.train(@text, :good)
    Classifier.train(@text, :good)
    Classifier.train("ololo", :bad)
  end

  test "perform" do
    PostWorker.jobs.clear
    assert_equal 0, Report.count
    assert_equal 0, PostWorker.jobs.size

    report = create :report, text: "", source_text: @text
    ReportsService.perform(report.id)

    assert_equal 1, PostWorker.jobs.size
  end

end
