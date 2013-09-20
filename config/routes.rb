Waytag::Application.routes.draw do
  scope module: :api do

  end

  scope module: :web do
    namespace :admin do
      root :to => 'reports#index'

      resources :tweets, only: :index

      resources :posts, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :reports, only: [:index, :destroy]

      resources :partners, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :cities, only: [:index, :edit, :new, :create, :update, :destroy]

      resources :bonuses, only: [:index, :edit, :new, :create, :update, :destroy]
    end
  end
end
