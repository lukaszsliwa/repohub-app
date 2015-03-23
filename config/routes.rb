Rails.application.routes.draw do
  devise_for :users

  resources :repositories
  resources :users

  root 'repositories#index'
end
