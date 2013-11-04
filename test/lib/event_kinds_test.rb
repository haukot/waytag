# encoding: utf-8

require 'test_helper'

class EventKindsTest < ActiveSupport::TestCase

  test "Detect dps from text" do
    ["ДПС"].each do |text|
      assert { EventKinds.from_text(text) == :dps }
    end
  end

  test "Detect dtp from text" do
    [
      "ДТП на олимпийском",
      "авария на олимпийском",
      "влетел на олимпийском"
    ].each do |text|
      assert { EventKinds.from_text(text) == :dtp }
    end
  end

  test "Detect cmr from text" do
    [ "камера на олимпийском" ].each do |text|
      assert { EventKinds.from_text(text) == :cmr }
    end
  end

  test "Detect rmnt from text" do
    [ "ремонт на олимпийском" ].each do |text|
      assert { EventKinds.from_text(text) == :rmnt }
    end
  end

  test "Detect prbk from text" do
    [ "Пробка на олимпийском" ].each do |text|
      assert { EventKinds.from_text(text) == :prbk }
    end
  end

end
