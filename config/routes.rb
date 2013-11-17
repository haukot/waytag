Waytag::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/q'

  namespace :api do
    resources :cities, only: [:index, :show] do
      scope :module => :cities do
        resources :tweets, only: :index
        resources :reports, only: :create
        resources :streets
      end
    end
  end

  namespace :rss do
    get "/:id" => "messages#feed"
  end

  scope module: :web do
    namespace :admin do
      root to: 'reports#index'

      resources :posts, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :reports, only: [:index, :destroy]

      resources :partners, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :cities, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :bonuses, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :ios_users, only: [:index, :destroy]
      resources :android_users, only: [:index, :destroy]
      resources :api_users, only: [:index, :destroy]
      resources :twitter_users, only: [:index, :destroy]
    end

    root to: 'cities#index'

    resources :cities, only: :index, path: '/' do
      scope module: :cities do
        resources :reports, only: [:index, :create]

        resources :partners, only: [:index, :show]
        resources :bonuses, only: [:index, :show]
      end
    end

    resources :posts, only: [:index, :show]
  end
end
