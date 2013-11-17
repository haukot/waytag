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

end
