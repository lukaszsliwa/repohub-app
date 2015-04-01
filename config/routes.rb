Rails.application.routes.draw do
  devise_for :users

  resources :repositories do
    resource :callback, only: :create, controller: 'repositories/callbacks'
    resources :users, only: [:index, :update, :destroy], controller: 'repositories/users'
    get '/tree/:tree_id(/:path)' => 'repositories#show', constraints: {tree_id: /[\w\.]+/, path: /[\w\.\/]+/}, as: :tree
    get '/blob/:tree_id/:path' => 'repositories/blobs#show', constraints: {path: /[\w\.\/]+/}, as: :blob
  end
  resources :users do
    resources :keys, controller: 'users/keys'
  end

  root 'repositories#index'
end
