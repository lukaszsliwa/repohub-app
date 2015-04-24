class Git::Repository::Tree::Content < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id/trees/:tree_id"

  belongs_to :tree, class_name: 'Git::Repository::Tree'

  def blob?
    self.type == 'blob'
  end

  def tree?
    self.type == 'tree'
  end
end