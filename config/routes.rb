Waytag::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/q'

  match "/401" => "errors#unauthorized", via: [:get, :post, :patch, :put, :delete]
  match "/403" => "errors#forbidden", via: [:get, :post, :patch, :put, :delete]
  match "/404" => "errors#not_found", via: [:get, :post, :patch, :put, :delete]
  match "/422" => "errors#unprocessable_entity", via: [:get, :post, :patch, :put, :delete]
  match "/500" => "errors#internal_server_error", via: [:get, :post, :patch, :put, :delete]
  match "/503" => "errors#service_unavailable", via: [:get, :post, :patch, :put, :delete]

  namespace :api do
    match "*all" => "application#cors_preflight_check", via: :options

    resource :user, only: [:create, :update]
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

  match 'auth/:provider/callback', to: 'web/admin/sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  scope module: :web do
    namespace :admin do
      resource :session, only: [:new, :create, :destroy]

      concern :sourceable do
        patch :on
        patch :off
      end

      root to: 'dashboard#show'

      resource :dashboard, only: :show

      resources :posts, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :reports, only: [:index, :destroy] do
        patch :good, on: :member
        patch :bad, on: :member
        patch :publish, on: :member
        patch :perform, on: :member
      end

      resources :classifier_features, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :streets, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :partners, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :cities, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :bonuses, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :web_users, only: [:index, :destroy], concerns: :sourceable
      resources :api_users, only: [:index, :destroy], concerns: :sourceable
      resources :twitter_users, only: [:index, :destroy, :create], concerns: :sourceable
      resources :vk_users, only: [:index, :destroy, :create], concerns: :sourceable
    end

    root to: 'cities#index'

    resource :classifier, only: [:show]
    resources :posts, only: [:index, :show]

    resources :cities, only: [:index], path: '/' do
      get "/" => "cities/dashboard#show"
      scope module: :cities do

        resource :dashboard, only: :show
        resources :stats, only: :index
        resources :reports, only: :create

        resources :partners, only: [:index, :show]
        resources :bonuses, only: [:index, :show]
      end
    end
  end
end
