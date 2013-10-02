Waytag::Application.routes.draw do
  get "reports/index"
  get "cities/index"
  scope module: :api do

  end

  scope module: :web do
    namespace :admin do
      root to: 'reports#index'

      resources :posts, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :reports, only: [:index, :destroy]
      resources :tweets, only: :index

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
        resources :reports, only: :index

        get "/" => "reports#index"
      end
    end
  end
end
