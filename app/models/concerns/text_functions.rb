# encoding: utf-8

module TextFunctions

  def contains_bad_data?
    question? || yell?
  end

  def question?
    text.include?("?")
  end

  def yell?
    text.mb_chars.upcase == text
  end

  def clean_text
    text.gsub(/(#ulsk|##{city.hashtag}|#{city.twitter_name}|#{city.hashtag})/i, '')
    .sub(/\A\[\d{1,2}:\d{1,2}\]/, '')
    .gsub(/\s+/, ' ')
    .strip
  end

  def text_without_via
    text.gsub(/via\s.*$/, '')
    .strip
  end

end
