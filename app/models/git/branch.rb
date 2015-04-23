class Git::Branch < ActiveResource::Base
  self.site = "http://git.repohub.dev/repositories/:repository_id"
end