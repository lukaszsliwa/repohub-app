class Git::Repository::Tree < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id"

  has_many :contents, class_name: 'Git::Repository::Tree::Content'
end