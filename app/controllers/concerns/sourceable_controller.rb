module SourceableController
  extend ActiveSupport::Concern

  included do
    def on
      sourceable.activate

      render nothing: true, status: 200
    end

    def off
      sourceable.deactivate

      render nothing: true, status: 200
    end
  end
end

