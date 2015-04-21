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

  def synchronize_commits_between(rev, current_rev, by)
    walker = Rugged::Walker.new(git)
    walker.push(current_rev)
    walker.hide(rev) if rev != '0000000000000000000000000000000000000000'
    walker.to_a.reverse.each do |walker_commit|
      commits.create_with(user: by).find_or_create_by(sha: walker_commit.oid)
    end
  end
end