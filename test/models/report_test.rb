# encoding: utf-8

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "generate_text_by_geo" do
    report = create :report, source_text:"", text: "", longitude: 14.5191613, latitude: 121.0132101
    report.generate_text_by_geo!

    assert { report.source_text.present? }
  end

  test "has no duplicate" do
    create :report, source_text: "Как дела"
    report = create :report, source_text: "на мосту?"

    assert { report.has_duplicate? == false }
  end

  test "has_duplicate by text" do
    create :report, text: "Как дела на мосту?"
    report = create :report, text: "Как дела на мосту?"

    assert { report.has_duplicate? }

    report = create :report, text: Text.clean("[17:11]    Дпс на [17:11] #uldriver инзенской #ulway via @UlwayStaging")
    report = create :report, text: Text.clean("[17:11] Дпс на инзенской #ulway")

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

end
