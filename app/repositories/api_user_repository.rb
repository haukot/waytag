module ApiUserRepository
  extend ActiveSupport::Concern

  included do
    include UsefullScopes

    scope :with_push_token, -> { where('push_token IS NOT NULL') }
    scope :android, -> { where(kind: :android) }
    scope :api, -> { where(kind: :api) }
    scope :ios, -> { where(kind: :ios) }
  end
end
