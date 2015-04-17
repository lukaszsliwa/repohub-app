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

    if commit.parents.empty?
      diff = commit.diff
    else
      diff = commit.parents[0].diff(commit)
    end

    diff.each_patch do |patch|
      self.additions += patch.stat[0]
      self.deletions += patch.stat[1]
      self.total_changes += patch.changes
    end
  end
end
