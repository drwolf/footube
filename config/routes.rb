require 'sidekiq/web'

Footube::Application.routes.draw do

  root :to => "home#index"

  get "home/index"

  devise_for :users

  resources :users do
    resources :videos, only: [:index]
  end

  resources :videos do
    get 'page/:page', action: :index, on: :collection
  end
  resources :users, only: [:show]

  mount Sidekiq::Web, at: "/sidekiq"

end
