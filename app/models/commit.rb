class Commit < ActiveRecord::Base
  belongs_to :user
  belongs_to :repository, counter_cache: :commits_count

  attr_accessor :git

  has_many :comments, dependent: :destroy

  before_save :initialize_attributes

  after_commit :on_create_notification,  on: :create

  default_scope { order 'issued_at DESC' }

  delegate :branches, :tags, :parents, :files, to: :git

  def git
    @git ||= Git::Repository::Commit.find sha, params: { repository_id: repository_id }
  end

  def different_committer_and_author?
    committer_name != author_name || committer_email != author_email
  end

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
    self.author_name = git_commit.author_name
    self.author_email = git_commit.author_email
    self.committer_name = git_commit.committer_name
    self.committer_email = git_commit.committer_email
    self.additions = git_commit.additions
    self.deletions = git_commit.deletions
    self.issued_at = git_commit.created_at
  end

  def on_create_notification
    Notification.create!(annotation: 'repository:commit:create', space_id: repository.space_id, repository_id: repository_id, user_id: user_id, resource_name: 'Commit', resource_id: id)
  end
end
