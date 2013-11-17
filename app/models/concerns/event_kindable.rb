module EventKindable
  extend ActiveSupport::Concern

  included do
    extend Enumerize
    enumerize :event_kind, in: EventKinds.all
  end
end
