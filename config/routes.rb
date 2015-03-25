Rails.application.routes.draw do
  devise_for :users

  resources :repositories do
    resources :users, only: [:index, :update, :destroy], controller: 'repositories/users'
  end
  resources :users

  root 'repositories#index'
end
