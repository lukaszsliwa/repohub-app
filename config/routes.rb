Rails.application.routes.draw do
  root 'dashboards#show'

  devise_for :users

  resources :keys
  resources :users, only: [:index, :create, :destroy]

  resources :callbacks, only: [] do
    resources :resources, only: [] do
      resource :branch, only: [:create, :destroy], controller: 'callbacks/resources/branches', constraints: {resource_id: /.+/}
      resource :tag, only: [:create, :destroy], controller: 'callbacks/resources/tags', constraints: {resource_id: /.+/}
      resource :commit, only: [:create, :destroy], controller: 'callbacks/resources/commits'
    end
  end

  concern :nested_repositories do
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
      end

      resources :trees, only: [] do
        get '/blobs/*id', to: 'repositories/trees/blobs#show', as: :blob, format: false
        resources :blobs, only: :index, controller: 'repositories/trees/blobs'
        get '/contents/*id', to: 'repositories/trees/contents#show', as: :content, format: false
        resources :contents, only: :index, controller: 'repositories/trees/contents'
        get '/raws/*id', to: 'repositories/trees/raws#show', as: :raw, format: false
        resources :raws, only: :index, controller: 'repositories/trees/raws'
      end
    end
  end

  resources :spaces, concerns: :nested_repositories

  concerns :nested_repositories
end
