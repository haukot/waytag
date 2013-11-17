# encoding: utf-8

require 'test_helper'

class TextComposerTest < ActiveSupport::TestCase
  def test_compose_with_twitetr_via
    source_text = "На Локомотивной 67 дежурит отряд ДПС. Соблюдайте скоростной режим."
    city = create :city
    user = create :twitter_user, name: "8xx8"

    report = create :report, source_text: source_text, sourceable: user, time: "2013-09-13 10:45"
    text = TextComposer.compose report

    assert_equal text, "[10:45] #{source_text} #ulway via @8xx8"
  end

  def test_compose
    source_text = "На Локомотивной 67 дежурит отряд ДПС. Соблюдайте скоростной режим."
    city = create :city

    report = create :report, source_text: source_text, time: "2013-09-13 10:45"
    text = TextComposer.compose report

    assert_equal text, "[10:45] #{source_text} #ulway"
  end

  def test_compose_long_text
    source_text = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
    city = create :city

    report = create :report, source_text: source_text, time: "2013-09-13 10:45"
    text = TextComposer.compose report

    assert_equal 140, text.length
    assert_equal "[10:45] 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012... #ulway", text
  end

end
