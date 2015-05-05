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
    repository.notifications.create(resource_name: 'repository_user:create', message: "Added new user @#{user.username}.")
    repository.space.notifications.create(resource_name: 'repository_user:create', message: "Repository ^#{repository.handle_with_space} has new user @#{user.username}.")
    repository.users.each do |member|
      member.notifications.create(resource_name: 'repository_user:create', message: "Repository ^#{repository.handle_with_space} has new user @#{user.username}.")
    end
    user.notifications.create(resource_name: 'repository_user:create', message: "You were added to ^#{repository.handle_with_space}.")
  end

  def on_destroy_notification
    begin
      repository.notifications.create(resource_name: 'repository_user:destroy', message: "@#{user.username} was removed.")
    rescue ActiveRecord::RecordNotSaved
      nil
    end
    repository.space.notifications.create(resource_name: 'repository_user:destroy', message: "@#{user.username} was removed from the repository ^#{repository.handle_with_space}.")
    repository.users.each do |member|
      next if member.id == self.user_id
      member.notifications.create(resource_name: 'repository_user:destroy', message: "@#{user.username} was removed from the repository ^#{repository.handle_with_space}.")
    end
    user.notifications.create(resource_name: 'repository_user:destroy', message: "You were removed from ^#{repository.handle_with_space}.")
  end
end
