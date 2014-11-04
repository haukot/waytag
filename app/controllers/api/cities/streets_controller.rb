class Api::Cities::StreetsController < Api::Cities::ApplicationController
  skip_before_action :authenticate_user!, only: :index

  ##
  # Получить список улиц города
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

    @q = resource_city.streets.ransack q_param
    @streets = @q.result.page(page).per(per_page)
  end
end
