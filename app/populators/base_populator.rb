# encoding: utf-8
class BasePopulator
  class << self

    def permit(*args)
      @_args = args
    end

    def _args
      @_args
    end

  end

  def initialize(raw_params = {})
    @raw_params = raw_params
    @strong_prams = ActionController::Parameters.new(raw_params)
  end

  private

  def strong_params
    @strong_prams.send :permit, self.class._args
  end

  def params
    @raw_params
  end

end
