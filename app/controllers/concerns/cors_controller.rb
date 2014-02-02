module CorsController
  extend ActiveSupport::Concern

  included do
    before_filter :cors_set_access_control_headers

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = '*'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Max-Age'] = "1728000"
    end

    def cors_preflight_check
      if request.method.to_s.downcase.to_sym == :options
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Max-Age'] = '1728000'
        render nothing: true, :content_type => 'text/plain'
      end
    end

  end
end

