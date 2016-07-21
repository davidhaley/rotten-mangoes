RottenMangoes::Application.routes.draw do
  
  root to: 'movies#index'

  namespace :admin, only: [:index, :destroy] do
    resources :users
  end

  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
end
