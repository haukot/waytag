# encoding: utf-8
require 'test_helper'

class MystemTest < MiniTest::Unit::TestCase
  def test_clean
    result = Mystem.clean('ДТП на Созидателей у 74 дома при повороте в сторону Ульяновского, левая полоса')
    assert_equal result, ["дтп", "на", "созидатель", "у", "дом|дома", "при|пря", "поворот", "в", "сторона", "ульяновский", "левый", "полоса"]
  end

  def test_parts_of_speach
    result = Mystem.parts_of_speach('ДТП на Созидателей у 74 дома при повороте в сторону Ульяновского, левая полоса')
    assert_equal result, {:S=>[["дтп", "S"], ["созидатель", "S"], ["дом", "S"], ["пря", "S"], ["поворот", "S"], ["сторона", "S"], ["полоса", "S"]], :P=>[["на", "P"], ["в", "P"]], :I=>[["у", "I"]], :A=>[["ульяновский", "A"], ["левый", "A"]]}
  end
end
