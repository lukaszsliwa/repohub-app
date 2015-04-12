class Commit < ActiveRecord::Base
  belongs_to :user
  belongs_to :repository, counter_cache: :commits_count

  before_save :initialize_attributes

  def to_param
    sha
  end

  def initialize_attributes
    commit = repository.git.lookup sha
    self.message = commit.message
    self.author = commit.author[:name]
    self.email = commit.author[:email]
    self.issued_at = commit.time
  end
end
