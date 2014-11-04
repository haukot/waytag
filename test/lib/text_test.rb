# encoding: utf-8

require 'test_helper'

class TextTest < ActiveSupport::TestCase
  test 'clean text' do
    create :city
    _clean_provider.each do |test_case|
      assert { test_case[1] == Text.clean(test_case[0]) }
    end
  end

  def _clean_provider
    [
      ['ULWAY!!!!!!       message', '! message'],
      [" \"\"  #Ulway ULWAY       message", 'message'],
      ['   #Ulway ULWAY       message', 'message'],
      ['#ulway message!', 'message!'],
      ['@ulway message', 'message'],
      ['ulway message', 'message'],
      ['test message', 'test message'],
      ['test #uldriver message', 'test message'],
      ['test #ulway message', 'test message'],
      ['test ulway ulway message', 'test message'],
      ['test #ulsk message', 'test message'],
      ['test @ulway message', 'test message'],
      ['test @ulway #Ulway message', 'test message'],
      ['test @UlWaY message', 'test message'],
      ['test message #ulsk', 'test message'],
      ['[12:12]   test message   ', 'test message']
    ]
  end
end
