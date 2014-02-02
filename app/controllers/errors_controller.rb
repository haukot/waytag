class ErrorsController < ActionController::Base
  include CorsController

  def service_unavailable
    @message = exception.message if exception
    @message ||= "The service is currently not available, please try later"

    render status: :service_unavailable
  end

  def not_found
    @message = exception.message if exception
    @message ||= "Not found"

    render status: :not_found
  end

  def unprocessable_entity
    @message = exception.message if exception
    @message ||= "Unprocessable entity"

    render status: :unprocessable_entity
  end

  def unauthorized
    @message = exception.message if exception
    @message ||= "Unauthorized"

    render status: :unauthorized
  end

  def forbidden
    @message = exception.message if exception
    @message ||= "Forbidden"

    render status: :forbidden
  end

  protected

  def exception
    @e ||= env["action_dispatch.exception"]
  end
end
