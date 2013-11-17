class Api::Cities::ReportsController < Api::Cities::ApplicationController

  ##
  # Закинуть телегу
  #
  # @param [String] text Текст сообщения
  # @param [String] event_kind Тип события
  # @param [String] token Идентификатор пользователя API
  # @param [String] type Тип пользователя API (android, ios или api)
  # @param optional [Float] longitude Долгота
  # @param optional [Float] latitude Широта
  def create
    @api_report = ApiReport.new(params.require(:report))

    if @api_report.valid?
      report = ReportPopulator.new.populate_from_api(@api_report, resource_city)
      ReportsWorker.perform_async(report.id)

      render nothing: true, status: :created
    else
      respond_with @api_report
    end
  end

  ##
  # Получить список телег
  #
  # @note Знай! По умолчанию отдается по 10 штук
  #
  # @overload index(q)
  #   @param [Hash] q Исполользуй Ransack бро!
  #
  # @see https://github.com/ernie/ransack/wiki/Basic-Searching
  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]

    @q = resource_city.reports.latest_posted.ransack(q_param)
    @reports = @q.result.page(page).per(per_page)
  end

end
