class Api::UsersController < Api::ApplicationController
  wrap_parameters :user
  skip_before_action :authenticate_user!,  only: :create

  ##
  # Зарегать юзера
  #
  # @overload user
  #   @param [String] token Идентификатор пользователя API (уникальная хуйня)
  #   @param [String] kind Тип пользователя API (android, ios или api)
  #   @param [String] push_token Если пользун хочет пуг, тот тут надо заполнить его пуш токен
  def create
    params.require(:user)

    user = Api::UserType.new(params[:user])
    user.save

    render json: user, serializer: ApiUserSerializer, location: nil, scope: nil
  end

  ##
  # Обновить пользователя
  #
  # @note Обоновить поля token и kind нельзя.
  #
  # @overload user
  #   @param [String] push_token Если пользун хочет пуг, тот тут надо заполнить его пуш токен
  def update
    params.require(:user)

    current_user.update(params[:user].permit(:push_token))
    render json: current_user, serializer: ApiUserSerializer, location: nil
  end
end
