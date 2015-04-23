class Git::Tag < ActiveResource::Base
  self.site = "http://git.repohub.dev/repositories/:repository_id"
end