class Git::Repository::Commit < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id/"

  belongs_to :repository, class_name: 'Git::Repository'

  has_many :files, class_name: 'Git::Repository::Commit::File'
end