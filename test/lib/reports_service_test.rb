# encoding: utf-8
require 'test_helper'

class ReportsServiceTest < ActiveSupport::TestCase

  setup do
    @text = generate :report_text
    ClassifierFeature.destroy_all

    10.times do
      Classifier.train(@text, :good)
    end
    10.times do
      Classifier.train("ololo", :bad)
    end
  end

  test "perform" do
    PostWorker.jobs.clear
    assert { 0 == Report.count }
    assert { 0 == PostWorker.jobs.size }

    report = create :report, text: "", source_text: @text
    ReportsService.perform(report.id)

    assert { 1 == PostWorker.jobs.size }
  end

  test "perform with geo data without text" do
    PostWorker.jobs.clear
    assert { 0 == Report.count }
    assert { 0 == PostWorker.jobs.size }

    report = create :report, source_text:"", text: "", longitude: 14.5191613, latitude: 121.0132101
    ReportsService.perform(report.id)

    assert { 1 == PostWorker.jobs.size }
  end


end
