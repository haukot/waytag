module BaseType
  extend ActiveSupport::Concern

  module ClassMethods
    def name
      superclass.name
    end

    def permit(*args)
      @_args = args
    end

    def _args
      @_args
    end
  end

  def assign_attributes(attrs = {})
    raise ApplicationController::BadRequest, "expected hash" unless attrs.kind_of? Hash

    permitted_attrs = attrs.send :permit, self.class._args
    super(permitted_attrs)
  end

end
