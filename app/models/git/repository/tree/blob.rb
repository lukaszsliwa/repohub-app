class Git::Repository::Tree::Blob < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id/trees/:tree_id"

  belongs_to :tree, class_name: 'Git::Repository::Tree'
end