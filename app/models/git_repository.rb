class GitRepository < Repository
  after_create  :server_command_add_repository
  after_destroy :server_command_delete_repository

  def server_command_add_repository
    `#{Settings.server.group.add.exec % {group: "repository_#{id}"}}`
    `#{Settings.server.git.add.exec % {repository: handle, group: "repository_#{id}"}}`
    `#{Settings.server.group.user.add.exec % {user: 'git', group: "repository_#{id}"}}`
    `#{Settings.server.git.own.exec % {group: "repository_#{id}", repository: handle}}`
    `#{Settings.server.git.permissions.exec % {repository: handle}}`
  end

  def server_command_delete_repository
    `#{Settings.server.git.delete.exec % {repository: handle}}`
    `#{Settings.server.group.delete.exec % {group: "repository_#{id}"}}`
  end

  def path
    Settings.server.git.repository.path % {name: handle}
  end

  def git
    @git ||= Rugged::Repository.new path
  end
end