class Api::Cities::ReportsController < Api::Cities::ApplicationController
  skip_before_filter :authenticate_user!, only: :index

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
    params.require(:report)

    api_report = Api::ReportType.new(params[:report])
    api_report.sourceable = current_user
    api_report.source_kind = current_user.kind
    api_report.city = resource_city

    if api_report.save
      ReportsWorker.perform_async(api_report.id)

      render nothing: true, status: :created, location: nil
    else
      respond_width api_report
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

    q = resource_city.reports.latest_posted.ransack(q_param)
    reports = q.result.page(page).per(per_page)

    meta = {
      count: reports.count,
      total_count: reports.total_count,
      current_page: reports.current_page,
      num_pages: reports.num_pages,
    }

    render json: reports.decorate, meta_data: meta, serializer: CustomArraySerializer, scope: nil
  end

end
