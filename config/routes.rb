Rails.application.routes.draw do
  devise_for :users

  resources :repositories do
    resources :users, only: [:index, :update, :destroy], controller: 'repositories/users'

    resources :commits do
      resource :callback, only: :create, controller: 'repositories/commits/callbacks'
    end

    get '/:reference_type/:reference_id' => redirect('/repositories/%{repository_id}/%{reference_type}/%{reference_id}/tree')

    get '/:reference_type/:reference_id/tree(/*path)' => 'repositories/references/trees#show', as: :reference_tree, constraints: {path: /.+/, reference_id: /.+/}
    get '/:reference_type/:reference_id/blob(/*path)' => 'repositories/references/blobs#show', as: :reference_blob, constraints: {path: /.+/, reference_id: /.+/}
    get '/:reference_type/:reference_id/commits/:id' => 'repositories/references/commits#show', as: :reference_commit, constraints: {reference_id: /.+/}

    post '/:reference_type/:reference_id/callback' => 'repositories/references/callbacks#create', constraints: {reference_id: /.+/}
    delete '/:reference_type/:reference_id/callback' => 'repositories/references/callbacks#destroy', constraints: {reference_id: /.+/}

    #get '/branches/:id' => redirect('/repositories/%{repository_id}/branches/%{id}/tree')
    #resources :branches, controller: 'repositories/branches', constraints: {branch_id: /.+/} do
    #  get '/tree(/*path)' => 'repositories/branches/trees#show', as: :tree, constraints: {path: /.+/}
    #  get '/blob(/*path)' => 'repositories/branches/blobs#show', as: :blob, constraints: {path: /.+/}
    #  resources :commits, only: [:index, :show], controller: 'repositories/branches/commits'
    #  resource :callback, only: [:create, :destroy], controller: 'repositories/branches/callbacks'
    #end
    #
    #resources :tags, controller: 'repositories/tags', constraints: {tag_id: /.+/} do
    #  get '/tree(/*path)' => 'repositories/tags/trees#show', as: :tree, constraints: {path: /.+/}
    #  get '/blob(/*path)' => 'repositories/tags/blobs#show', as: :blob, constraints: {path: /.+/}
    #  resources :commits, only: [:index, :show], controller: 'repositories/tags/commits'
    #  resource :callback, only: [:create, :destroy], controller: 'repositories/tags/callbacks'
    #end
  end
  resources :users do
    resources :keys, controller: 'users/keys'
  end

  root 'repositories#index'
end
