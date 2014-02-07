Footube::Application.routes.draw do

  root :to => "home#index"

  get "home/index"

  devise_for :users

  resources :users do
    resources :videos, only: [:index]
  end

  resources :videos
  resources :users, only: [:show]

end
