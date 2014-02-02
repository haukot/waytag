class ApplicationController < ActionController::Base
  class UnprocessableEntity < StandardError; end
  class Unauthorized < StandardError; end
  class Forbidden < StandardError; end
  class ServiceUnavailable < StandardError; end

  include Concerns::FlashHelper
end
