class Api::CitiesController < Api::ApplicationController
  ##
  # Получить список городов
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

    @q = City.ransack q_param
    @cities = @q.result.page(page).per(per_page)
  end

end