require_dependency 'exec/repository/user'

class RepositoryUser < ActiveRecord::Base
  belongs_to :repository
  belongs_to :user

  after_commit  :exec_repository_user_create, on: :create
  after_commit :exec_repository_user_destroy, on: :destroy

  def path

  end

  def default_params
    @default_params ||= {params: {repository_id: repository.id}}
  end

  def exec_repository_user_create
    Exec::Repository::User.find(user.username, default_params).post(:link, space: repository.space.try(:handle), handle: repository.handle)
  end

  def exec_repository_user_destroy
    Exec::Repository::User.find(user.username, default_params).delete(:link, space: repository.space.try(:handle), handle: repository.handle)
  end
end
