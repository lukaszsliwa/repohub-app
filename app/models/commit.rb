class Commit < ActiveRecord::Base
  belongs_to :user
  belongs_to :repository, counter_cache: :commits_count

  before_save :initialize_attributes

  after_commit :on_create_notification,  on: :create

  def to_param
    sha
  end

  def created_by
    user
  end

  def short_sha
    sha[0, 8]
  end

  def initialize_attributes
    git_commit = Git::Repository::Commit.find sha, params: {repository_id: repository_id}
    self.message = git_commit.message
    self.author = git_commit.author_name
    self.email = git_commit.author_email
    self.issued_at = git_commit.created_at
  end

  def on_create_notification
    repository.notifications.create resource_name: 'repository:commit:create', message: "@#{created_by.username} created new commit ##{short_sha}"
    if repository.space.present?
      repository.space.notifications.create resource_name: 'repository:commit:create', message: "^#{repository.handle_with_space} has new commit ##{short_sha}"
    end
    repository.users.each do |member|
      member.notifications.create resource_name: 'repository:commit:create', message: "@#{created_by.username} created new commit ##{short_sha} in ^#{repository.handle_with_space}"
    end
  end
end
