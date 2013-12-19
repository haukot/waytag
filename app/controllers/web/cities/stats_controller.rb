#encoding: utf-8
class Web::Cities::StatsController < Web::Cities::ApplicationController
  def index
    @all = Report.this_year.dtp.count

    by_month = Report.this_year.dtp.by_month
    gon.by_month = {
      data: by_month.map { |t| t.count.to_i },
      labels: by_month.map { |t| l(t.month.to_date, format: :month) }
    }

    by_day = Report.this_year.dtp.by_day
    gon.by_day = {
      data: by_day.map { |t| t.count.to_i },
      labels: %w(ПН ВТ СР ЧТ ПТ СБ ВС)
    }

    by_hour = Report.this_year.dtp.by_hour.select { |t| t.count.to_i > 10 }
    gon.by_hour = {
      data: by_hour.map { |t| t.count.to_i },
      labels: by_hour.map { |t| t.hour.to_i + 4 }
    }

    gon.danger_zones = { labels: [], data: [] }

    streets = {
       "Нариманова" => %w(нариман наримаш победы),
       "Карла Маркса" => %w(карла маркса),
       #"Путепровод" => %w(путепровод),
       #"Проспект" => %w(гая),
       #"Инзенская" => %w(инзен),
       "Рябикова" => %w(рябик),
       "Кирова" => %w(киров),
       #"Димитровград" => %w(димитровград),
       #"Радищева" => %w(радищ),
       "Урицкого" => %w(уриц),
       "Созидателей" => %w(созид),
       "Майская гора" => %w(май),
       "Камышинская" => %w(камыш),
       "Локомотивная" => %w(локомотив),
       "Гоначарова" => %w(гончаров),
       "Минаева" => %w(минаев),
       "12 сентября" => %w(12 сент),
       "Пушкаревское кольцо" => %w(пушкаревск кольцо),
       "Московское шоссе" => %w(московск),
       "Откябрьская" => %w(октябрь),
       "Императорский мост" => %w(старый старом император),
       "Президентский мост" => %w(новом нового новый президент)
    }

    streets.each_pair do |e, cond|
      gon.danger_zones[:data] << Report.this_year.dtp.in_street(cond).count
    end

    gon.danger_zones[:labels] = streets.keys
  end

end
