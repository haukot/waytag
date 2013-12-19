# encoding: utf-8
class TextComposer
  class << self
    def compose(report)
      report.text = report.source_text

      via = compose_via report

      _text = report.time.strftime('[%H:%M]') + " {?} ##{report.city.hashtag}#{via}"

      text = report.clean_text.truncate max_text_length(_text)

      _text.gsub(/\{\?\}/, text)
    end

    def max_text_length(text)
      143 - text.size
    end

    def compose_via(report)
       " via @#{report.sourceable.screen_name}" if report.sourceable.kind_of?(TwitterUser)
    end

  end
end
