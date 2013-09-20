module Sourceable
  extend ActiveSupport::Concern

  included do
    has_many :reports

    state_machine :state, initial: :active do
      event :block do
        transition active: :blocked
      end

      event :activate do
        transition blocked: :acitve
      end
    end
  end
end
