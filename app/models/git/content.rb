class Git::Content < ActiveResource::Base
  self.site = "http://git.repohub.dev/repositories/:repository_id/trees/:tree_id"

  def blob?
    self.type == 'blob'
  end

  def tree?
    self.type == 'tree'
  end
end