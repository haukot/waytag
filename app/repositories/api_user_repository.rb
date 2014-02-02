module ApiUserRepository
  extend ActiveSupport::Concern

  included do
    include UsefullScopes

    scope :with_push_token, -> { where('push_token IS NOT NULL') }
    scope :android, -> { where(kind: :android) }
  end

end
