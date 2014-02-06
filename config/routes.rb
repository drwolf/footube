Footube::Application.routes.draw do

  resources :foos

  root :to => "home#index"

  get "home/index"

  devise_for :users

  resources :users do
    resources :videos
  end

end
