require_dependency 'exec/group/user'
require_dependency 'exec/repository/user'

class RepositoryUser < ActiveRecord::Base
  belongs_to :repository
  belongs_to :user

  after_commit  :exec_repository_user_create, on: :create
  after_commit :exec_repository_user_destroy, on: :destroy

  def exec_repository_user_create
    Exec::Group::User.find(user.username, params: {group_id: repository.id}).post :link
    Exec::Repository::User.find(user.username, params: {repository_id: repository.handle}).post :link
  end

  def exec_repository_user_destroy
    Exec::Group::User.find(user.username, params: {group_id: repository.id}).delete :link
    Exec::Repository::User.find(user.username, params: {repository_id: repository.handle}).delete :link
  end
end
