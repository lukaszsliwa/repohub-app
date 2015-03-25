class Repository::Git < Repository
  after_create  :server_command_add_repository
  after_update  :server_command_rename_repository, if: :handle_changed?
  after_destroy :server_command_delete_repository

  def server_command_add_repository
    `#{Settings.server.group.add.exec % {group: "repository_#{id}"}}`
    `#{Settings.server.git.add.exec % {repository: handle, group: "repository_#{id}"}}`
    `#{Settings.server.group.user.add.exec % {user: 'git', group: "repository_#{id}"}}`
    `#{Settings.server.git.own.exec % {group: "repository_#{id}", repository: handle}}`
    `#{Settings.server.git.permissions.exec % {repository: handle}}`
  end

  def server_command_rename_repository
    `#{Settings.server.git.add.exec % {repository: handle, old_repository: handle_was}}`
  end

  def server_command_delete_repository
    `#{Settings.server.git.delete.exec % {repository: handle}}`
    `#{Settings.server.group.delete.exec % {group: "repository_#{id}"}}`
  end
end