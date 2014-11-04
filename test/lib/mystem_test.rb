# encoding: utf-8
#
require 'test_helper'

class MystemTest < ActiveSupport::TestCase
  test 'clean' do
    result = Mystem.clean('ДТП на Созидателей у 74 дома при повороте в сторону Ульяновского, левая полоса')
    assert_equal result, ['дтп', 'на', 'созидатель', 'у', 'дом|дома', 'при|пря', 'поворот', 'в', 'сторона', 'ульяновский', 'левый', 'полоса']
  end

  test 'Parts of speach' do
    result = Mystem.parts_of_speach('ДТП на Созидателей у 74 дома при повороте в сторону Ульяновского, левая полоса')
    assert_equal result, S: [
      %w(дтп S), %w(созидатель S), %w(дом S), %w(пря S),
      %w(поворот S), %w(сторона S), %w(полоса S)
    ], P: [
      %w(на P), %w(в P)
    ], I: [
      %w(у I)
    ], A: [
      %w(ульяновский A), %w(левый A)
    ]
  end
end
