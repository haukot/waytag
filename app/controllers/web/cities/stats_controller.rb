# encoding: utf-8
class Web::Cities::StatsController < Web::Cities::ApplicationController
  def index
    @current_year = params[:year]
    @current_year ||= DateTime.current.year
    @current_date = DateTime.new(@current_year.to_i)

    @years = 2012.upto(DateTime.current.year).to_a

    colors = %w(#c83539  #f2c285 #19bb9b #38a6c9)
    kinds = Report.event_kind.values
    @by_type = kinds.map.with_index do |k, i|
      {
        label: t(k),
        value: Report.in_year(@current_date).where(event_kind: k).count,
        color: colors[i]
      }
    end
    gon.by_type = @by_type

    @all = resource_city.reports.in_year(@current_date).count

    if @current_year.to_i == DateTime.current.year.to_i
      @avg = @all / (DateTime.current.yday)
    else
      @avg = @all / 365
    end

    by_month = resource_city.reports.in_year(@current_date).dtp.by_month
    gon.by_month = {
      data: by_month.map { |t| t.count.to_i },
      labels: by_month.map { |t| l(t.month.to_date, format: :month) }
    }

    by_day = resource_city.reports.in_year(@current_date).dtp.by_day
    gon.by_day = {
      data: by_day.map { |t| t.count.to_i },
      labels: %w(ПН ВТ СР ЧТ ПТ СБ ВС)
    }

    by_hour = resource_city.reports.in_year(@current_date).dtp.by_hour.select { |t| t.count.to_i > 0 }
    gon.by_hour = {
      data: by_hour.map { |t| t.count.to_i },
      labels: by_hour.map do |t|
        t.hour.to_i + 3
      end
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
      gon.danger_zones[:data] << resource_city.reports.dtp.in_street(cond).count
    end

    gon.danger_zones[:labels] = streets.keys
  end

end
