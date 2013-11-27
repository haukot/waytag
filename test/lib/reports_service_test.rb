# encoding: utf-8
require 'test_helper'

class ReportsServiceTest < ActiveSupport::TestCase

  setup do
    @text = "На Локомотивной 67 дежурит отряд ДПС. Соблюдайте скоростной режим."
    ClassifierFeatures.destroy_all

    10.times do
      Classifier.train(@text, :good)
    end
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
