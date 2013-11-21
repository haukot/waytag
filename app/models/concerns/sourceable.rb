module Sourceable
  extend ActiveSupport::Concern

  included do
    has_many :reports

    state_machine :state, initial: :active do
      event :deactivate do
        transition active: :blocked
      end

      event :activate do
        transition blocked: :active
      end
    end
  end
end
