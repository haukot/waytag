module BaseType
  extend ActiveSupport::Concern

  module ClassMethods
    delegate :name, to: :superclass

    def permit(*args)
      @_args = args
    end

    attr_reader :_args
  end

  def assign_attributes(attrs = {})
    fail ApplicationController::BadRequest, 'expected hash' unless attrs.is_a? Hash

    permitted_attrs = attrs.send :permit, self.class._args
    super(permitted_attrs)
  end
end
