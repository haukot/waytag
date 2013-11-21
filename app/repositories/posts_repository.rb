module PostsRepository
  extend ActiveSupport::Concern

  included do
    include UsefullScopes

  end
end
