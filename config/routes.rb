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
    get '/:reference_type/:reference_id/commits/count(.:format)' => 'repositories/references/commits#count', as: :reference_commits_count, constraints: {reference_id: /.+/}
    get '/:reference_type/:reference_id/commits/:id' => 'repositories/references/commits#show', as: :reference_commit, constraints: {reference_id: /.+/}

    post '/:reference_type/:reference_id/callback' => 'repositories/references/callbacks#create', constraints: {reference_id: /.+/}
    delete '/:reference_type/:reference_id/callback' => 'repositories/references/callbacks#destroy', constraints: {reference_id: /.+/}
  end
  resources :keys

  root 'repositories#index'
end
