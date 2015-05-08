require_dependency 'exec/repository/user'

class RepositoryUser < ActiveRecord::Base
  belongs_to :repository
  belongs_to :user

  after_commit :exec_repository_user_create, on: :create
  after_commit :exec_repository_user_destroy, on: :destroy

  after_commit :on_create_notification, on: :create
  after_commit :on_destroy_notification, on: :destroy

  def default_params
    @default_params ||= {params: {repository_id: repository.id}}
  end

  def exec_repository_user_create
    Exec::Repository::User.find(user.username, default_params).post(:link, space: repository.space.try(:handle), handle: repository.handle)
  end

  def exec_repository_user_destroy
    Exec::Repository::User.find(user.username, default_params).delete(:link, space: repository.space.try(:handle), handle: repository.handle)
  end

  def on_create_notification
    user.repository_subscriptions.create repository_id: repository_id
    Notification.create!(annotation: 'repository:user:create', space_id: repository.space_id, repository_id: repository_id, user_id: user_id, resource_name: 'RepositoryUser', resource_id: id)
  end

  def on_destroy_notification
    begin
      Notification.create!(annotation: 'repository:user:destroy', space_id: repository.space_id, repository_id: repository_id, user_id: user_id, resource_name: 'RepositoryUser', resource_id: id)
    rescue ActiveRecord::RecordNotSaved
      nil
    end
  end
end
