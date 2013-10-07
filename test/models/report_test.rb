# encoding: utf-8

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "question?" do
    report = create :report, text: "Как дела на мосту?"

    assert report.question?
  end

  test "yell?" do
    report = create :report, text: "МАТЬ ПЕРЕМАТЬ!"

    assert report.yell?
  end

  test "with_mentions?" do
    report = create :report, text: "По центру катается форд дпс с парконом @ololo"

    assert report.with_mentions?
  end

  test "rt?" do
    report = create :report, text: "RT Локомотивная от 4 мкр.едет еле еле."

    assert report.rt?
  end

  test "text without via" do
    _without_via_provider.each do |test_case|
      report = create :report, text: test_case[0]
      assert_equal report.text_without_via, test_case[1]
    end
  end

  def _without_via_provider
    [
      ["test message via @8xx8", "test message"],
      ["test message #ulway via ICQ: 625921555", "test message #ulway"],
      ["test message via 8xx8", "test message"],
    ]
  end

  test "clean text" do
    _clean_provider.each do |test_case|
      report = create :report, text: test_case[0]
      assert_equal test_case[1], report.clean_text
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
