# encoding: utf-8

class EventKinds
  class << self
    def all
      [:dps, :dtp, :cmr, :rmnt, :prbk]
    end

    def from_text(text)
      return :dtp if text =~ /дтп|авария|влетел|прилетел|догнал/i
      return :prbk if text =~ /пробка|стоим\sот/i
      return :dps if text =~ /дпс/i
      return :cmr if text =~ /радар|камера/i
      return :rmnt if text =~ /ремонт/i
      nil
    end

  end
end
