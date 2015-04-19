class GitRepository < Repository
  after_create  :server_command_add_repository
  after_destroy :server_command_delete_repository

  def server_command_add_repository
    Rails.logger.info `#{Rails.root}/bin/application/repository/create.sh #{handle} #{id}`
  end

  def server_command_delete_repository
    Rails.logger.info `#{Rails.root}/bin/application/repository/destroy.sh #{handle} #{id}`
  end

  def path
    Settings.git.repository.path % {name: handle}
  end

  def git
    @git ||= Rugged::Repository.new path
  end
end