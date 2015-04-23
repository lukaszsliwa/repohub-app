class Git::Blob < ActiveResource::Base
  self.site = "http://git.repohub.dev/repositories/:repository_id/trees/:tree_id"
end