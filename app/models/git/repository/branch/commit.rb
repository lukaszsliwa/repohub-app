class Git::Repository::Branch::Commit < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id/branches/:branch_id"

  belongs_to :branch, class_name: 'Git::Repository::Branch'
end