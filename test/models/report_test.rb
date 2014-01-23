# encoding: utf-8

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "generate_text_by_geo" do
    report = create :report, source_text:"", text: "", longitude: 14.5191613, latitude: 121.0132101
    report.generate_text_by_geo!

    assert { report.source_text.present? }
  end

  test "safe_text" do
    report = create :report, source_text: "Как дела @asdasd #ljkjasd @alsdkjasd"

    assert { report.safe_text.include?('#') == false }
    assert { report.safe_text.include?('@') == false }
  end

  test "has no duplicate" do
    create :report, source_text: "Как дела"
    report = create :report, source_text: "на мосту?"

    assert { report.has_duplicate? == false }
  end

  test "has_duplicate by source text" do
    create :report, source_text: "Как дела на мосту?"
    report = create :report, source_text: "Как дела на мосту?"

    assert { report.has_duplicate? }
  end

  test "has_duplicate by text" do
    create :report, text: "Как дела на мосту?"
    report = create :report, text: "Как дела на мосту?"

    assert { report.has_duplicate? }
  end

  test "Detect has_duplicates only on 2 hours text" do
    create :report, text: "Как дела на мосту?", time: Time.now - 3.hours
    report = create :report, text: "Как дела на мосту?", time: Time.now

    assert { report.has_duplicate? == false }
  end

  test "question?" do
    report = create :report, text: "Как дела на мосту?"

    assert { report.question?  == true }
  end

  test "yell?" do
    report = create :report, text: "МАТЬ ПЕРЕМАТЬ!"

    assert { report.yell? == true }

    report = create :report, text: "МАТЬ просто мать!"

    assert { report.yell? == false }
  end

  test "with_mentions?" do
    report = create :report, text: "По центру катается форд дпс с парконом @ololo"

    assert { report.with_mentions? == true }
  end

  test "text without via" do
    _without_via_provider.each do |test_case|
      report = create :report, text: test_case[0]
      assert { report.text_without_via == test_case[1] }
    end
  end

  def _without_via_provider
    [
      ["test message via @8xx8", "test message"],
      ["test message #ulway via ICQ: 625921555", "test message"],
      ["test message via 8xx8", "test message"],
    ]
  end

  test "clean text" do
    _clean_provider.each do |test_case|
      report = create :report, text: test_case[0]
      assert { test_case[1] == report.clean_text }
    end
  end

  def _clean_provider
    [
      ["test message", "test message"],
      ["test #ulway message", "test message"],
      ["test ulway ulway message", "test message"],
      ["test #ulsk message", "test message"],
      ["test @ulway message", "test message"],
      ["test @ulway #Ulway message", "test message"],
      ["test @UlWaY message", "test message"],
      ["test message #ulsk", "test message"],
      ["[12:12]   test message   ", "test message"],
    ]
  end
end
