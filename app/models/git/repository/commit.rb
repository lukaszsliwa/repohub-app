class Git::Repository::Commit < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id/"

  belongs_to :repository, class_name: 'Git::Repository'

  def different_committer_and_author?
    committer_name != author_name || committer_email != author_email
  end
end