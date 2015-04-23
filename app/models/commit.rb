class Commit < ActiveRecord::Base
  belongs_to :user
  belongs_to :repository, counter_cache: :commits_count

  before_save :initialize_attributes

  def to_param
    sha
  end

  def initialize_attributes
    git_commit = Git::Commit.find sha
    self.message = git_commit.message
    self.author = git_commit.author_name
    self.email = git_commit.author_email
    self.issued_at = git_commit.created_at
  end
end
