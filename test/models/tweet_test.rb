#encoding: utf-8
require 'test_helper'

class TweetTest < ActiveSupport::TestCase

  test "rt?" do
    tweet = build :tweet, text: "RT Локомотивная от 4 мкр.едет еле еле."

    assert { tweet.retweeted? }
  end

  test "more two mentions" do
    tweet = build :tweet, text: '[10:59] @Sekreeet да в курсе, уже парочка таких имеется)) #ulway via @fire_beard'
    assert { tweet.more_two_mentions? }

    tweet = build :tweet, text: '@asd asd asduhieudhk dalsju '
    assert { !tweet.more_two_mentions? }
  end


end