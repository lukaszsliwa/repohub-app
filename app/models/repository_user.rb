class RepositoryUser < ActiveRecord::Base
  belongs_to :repository
  belongs_to :user

  after_create  :server_command_after_create
  after_destroy :server_command_after_destroy

  def server_command_after_create
    `#{Settings.server.link.add.exec % {login: user.username, repository: repository.handle}}`
    `#{Settings.server.group.user.add.exec % {user: user.username, group: "repository_#{repository.id}"}}`
  end

  def server_command_after_destroy
    `#{Settings.server.link.delete.exec % {login: user.username, repository: repository.handle}}`
    `#{Settings.server.group.user.delete.exec % {user: user.username, group: "repository_#{repository.id}"}}`
  end
end
