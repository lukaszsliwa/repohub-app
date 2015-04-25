Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:create, :destroy]

  resources :repositories do
    resources :users, only: [:index, :update, :destroy], controller: 'repositories/users'

    resources :branches, controller: 'repositories/branches' do
      resources :commits, controller: 'repositories/branches/commits', constraints: {id: /.+/}
      resources :blobs, controller: 'repositories/branches/blobs', constraints: {id: /.+/}
      resources :contents, controller: 'repositories/branches/contents', constraints: {id: /.+/}
    end

    resources :tags, controller: 'repositories/tags', constraints: {id: /.+/} do
      resources :commits, controller: 'repositories/tags/commits', constraints: {id: /.+/}
      resources :blobs, controller: 'repositories/tags/blobs', constraints: {id: /.+/}
      resources :contents, controller: 'repositories/tags/contents', constraints: {id: /.+/}
    end

    resources :commits, controller: 'repositories/commits' do
      collection { get :count }
      resource :callback, only: :create, controller: 'repositories/commits/callbacks'
    end

    resources :trees, only: [] do
      get '/blobs/*id', to: 'repositories/trees/blobs#show', as: :blob, format: false
      resources :blobs, only: :index, controller: 'repositories/trees/blobs'
      get '/contents/*id', to: 'repositories/trees/contents#show', as: :content, format: false
      resources :contents, only: :index, controller: 'repositories/trees/contents'
      get '/raws/*id', to: 'repositories/trees/raws#show', as: :raw, format: false
      resources :raws, only: :index, controller: 'repositories/trees/raws'
    end

    #get '/:reference_type/:reference_id' => redirect('/repositories/%{repository_id}/%{reference_type}/%{reference_id}/tree')

    #get '/:reference_type/:reference_id/tree(/*path)' => 'repositories/references/trees#show', as: :reference_tree, constraints: {path: /.+/, reference_id: /.+/}
    #get '/:reference_type/:reference_id/blob(/*path)' => 'repositories/references/blobs#show', as: :reference_blob, constraints: {path: /.+/, reference_id: /.+/}
    #get '/:reference_type/:reference_id/commits/count(.:format)' => 'repositories/references/commits#count', as: :reference_commits_count, constraints: {reference_id: /.+/}
    #get '/:reference_type/:reference_id/commits/:id' => 'repositories/references/commits#show', as: :reference_commit, constraints: {reference_id: /.+/}

    #post '/:reference_type/:reference_id/callback' => 'repositories/references/callbacks#create', constraints: {reference_id: /.+/}
    #delete '/:reference_type/:reference_id/callback' => 'repositories/references/callbacks#destroy', constraints: {reference_id: /.+/}
  end
  resources :keys

  root 'repositories#index'
end
