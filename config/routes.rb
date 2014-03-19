require 'sidekiq/web'

Footube::Application.routes.draw do

  root :to => "home#index"

  get "home/index"

  devise_for :users

  resources :users do
    get :videos
  end

  resources :videos do
    get 'page/:page', action: :index, on: :collection
    get 'version/:version_id', action: :show, as: :version
    get 'version/:version_id/progress', controller: :video_versions, action: :progress
  end
  resources :users, only: [:show]

  resource :user do
    get :videos
  end

  mount Sidekiq::Web, at: "/sidekiq"

end
