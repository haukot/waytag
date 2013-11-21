Waytag::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/q'

  namespace :api do
    resources :cities, only: [:index, :show] do
      scope module: :cities do
        resources :reports, only: [:index, :create]
        resources :streets, only: [:index]
      end
    end
  end

  namespace :rss do
    get "/:id" => "messages#feed"
  end

  scope module: :web do
    namespace :admin do
      concern :sourceable do
        patch :on
        patch :off
      end

      root to: 'reports#index'

      resources :posts, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :reports, only: [:index, :destroy] do
        patch :good, on: :member
        patch :bad, on: :member
        patch :publish, on: :member
      end

      resources :partners, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :cities, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :bonuses, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :ios_users, only: [:index, :destroy], concerns: :sourceable
      resources :android_users, only: [:index, :destroy], concerns: :sourceable
      resources :api_users, only: [:index, :destroy], concerns: :sourceable
      resources :twitter_users, only: [:index, :destroy, :create], concerns: :sourceable
    end

    root to: 'cities#index'

    resources :cities, only: [:index, :show], path: '/' do
      scope module: :cities do
        resources :reports, only: :create

        resources :partners, only: [:index, :show]
        resources :bonuses, only: [:index, :show]
      end
    end

    resources :posts, only: [:index, :show]
  end
end
