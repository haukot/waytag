class Api::Cities::ReportsController < Api::Cities::ApplicationController

  ##
  # Закинуть телегу
  #
  # @overload report
  #   @param [String] text Текст сообщения
  #   @param [String] event_kind Тип события
  #   @param [String] token Идентификатор пользователя API
  #   @param [String] from Тип пользователя API (android, ios или api)
  #   @param optional [Float] longitude Долгота
  #   @param optional [Float] latitude Широта
  def create
    params.require(:report).permit(:token).permit(:from).permit(:event_kind).permit(:text).permit(:longitude).permit(:latitude).permit(:push_token).permit(:accuracy)

    @api_report = Api::ReportType.new(params[:report])

    if @api_report.valid?
      if @api_report.sourceable_not_blocked?
        report = ReportPopulator.new.populate_from_api(@api_report, resource_city)
        ReportsWorker.perform_async(report.id)

        render nothing: true, status: :created
      else
        render nothing: true, status: :forbidden
      end
    else
      respond_with @api_report, location: nil
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
    @reports = @q.result.page(page).per(per_page).decorate
  end

end
