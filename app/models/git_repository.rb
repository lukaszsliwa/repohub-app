class GitRepository < Repository
  before_create :git_repository_create
  after_destroy :git_repository_destroy

  delegate :size, to: :git, allow_nil: true

  def git_repository_create
    git_repository = Git::Repository.new(name: self.handle)
    git_result = git_repository.save
    git_repository.errors.full_messages.each do |message|
      errors.add :base, message
    end
    git_result
  end

  def server_command_add_repository
    Rails.logger.info `#{Rails.root}/bin/application/repository/create.sh #{handle} #{id}`
  end

  def server_command_delete_repository
    Rails.logger.info `#{Rails.root}/bin/application/repository/destroy.sh #{handle} #{id}`
  end

  def path
    Settings.git.repository.path % {name: handle}
  end

  def synchronize_commits_between(rev, current_rev, by)
    walker = Rugged::Walker.new(git)
    walker.push(current_rev)
    walker.hide(rev) if rev != '0000000000000000000000000000000000000000'
    walker.to_a.reverse.each do |walker_commit|
      commits.create_with(user: by).find_or_create_by(sha: walker_commit.oid)
    end
  end

  def git
    @git ||= Git::Repository.find(handle) rescue nil
  end
end