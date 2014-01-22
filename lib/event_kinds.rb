# encoding: utf-8

class EventKinds
  class << self
    def all
      [:dps, :dtp, :cmr, :prbk]
    end

    def all_translated
      translated = {}
      all.each { |ek| translated[ek] = I18n.t(ek) }
      translated
    end

    def from_text(text)
      return :dtp if text =~ /дтп|авария|влетел|прилетел|догнал/i
      return :prbk if text =~ /пробка|стоим\sот|транспортный коллапс|еле ползет/i
      return :dps if text =~ /дпс/i
      return :cmr if text =~ /радар|камер/i
      nil
    end

  end
end
