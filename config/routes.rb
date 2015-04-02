Rails.application.routes.draw do
  devise_for :users

  resources :repositories do
    resources :users, only: [:index, :update, :destroy], controller: 'repositories/users'
    resource :callback, only: :create

    resources :branches, controller: 'repositories/branches' do
      resources :commits, only: [:index, :show], controller: 'repositories/branches/commits'
      resource :callback, only: [:create, :destroy], controller: 'repositories/branches/callbacks', constraints: {branch_id: /.+/}
    end

    resources :tags, controller: 'repositories/tags' do
      resources :commits, only: [:index, :show], controller: 'repositories/tags/commits'
      resource :callback, only: [:create, :destroy], controller: 'repositories/tags/callbacks', constraints: {tag_id: /.+/}
    end
  end
  resources :users do
    resources :keys, controller: 'users/keys'
  end

  root 'repositories#index'
end
