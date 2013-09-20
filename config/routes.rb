Waytag::Application.routes.draw do
  resources :tweets

  resources :posts

  resources :reports

  resources :partners

  resources :cities

  resources :bonuses
end
