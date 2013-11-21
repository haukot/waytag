# encoding: utf-8
require 'test_helper'

class ReportsServiceTest < ActiveSupport::TestCase

  setup do
    @text = "На Локомотивной 67 дежурит отряд ДПС. Соблюдайте скоростной режим."
    ClassifierFeatures.destroy_all

    Classifier.train(@text, :good)
    Classifier.train(@text, :good)
    Classifier.train(@text, :good)
    Classifier.train("ololo", :bad)
  end

  test "perform" do
    PostWorker.jobs.clear
    assert { 0 == Report.count }
    assert { 0 == PostWorker.jobs.size }

    report = create :report, text: "", source_text: @text
    ReportsService.perform(report.id)

    assert { 1 == PostWorker.jobs.size }
  end

end
