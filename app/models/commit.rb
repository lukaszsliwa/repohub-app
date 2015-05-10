class Commit < ActiveRecord::Base
  belongs_to :user
  belongs_to :repository, counter_cache: :commits_count

  attr_accessor :git

  has_many :comments, dependent: :destroy

  before_save :initialize_attributes

  after_commit :on_create_notification,  on: :create

  default_scope { order 'id DESC' }

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
    Notification.create!(annotation: 'repository:commit:create', space_id: repository.space_id, repository_id: repository_id, user_id: user_id, resource_name: 'Commit', resource_id: id)
  end
end
