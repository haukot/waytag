# encoding: utf-8
#
require 'test_helper'

class MystemTest < ActiveSupport::TestCase
  test "clean" do
    result = Mystem.clean('ДТП на Созидателей у 74 дома при повороте в сторону Ульяновского, левая полоса')
    assert_equal result, ["дтп", "на", "созидатель", "у", "дом|дома", "при|пря", "поворот", "в", "сторона", "ульяновский", "левый", "полоса"]
  end

  test "Parts of speach" do
    result = Mystem.parts_of_speach('ДТП на Созидателей у 74 дома при повороте в сторону Ульяновского, левая полоса')
    assert_equal result, {:S=>[["дтп", "S"], ["созидатель", "S"], ["дом", "S"], ["пря", "S"], ["поворот", "S"], ["сторона", "S"], ["полоса", "S"]], :P=>[["на", "P"], ["в", "P"]], :I=>[["у", "I"]], :A=>[["ульяновский", "A"], ["левый", "A"]]}
  end
end
