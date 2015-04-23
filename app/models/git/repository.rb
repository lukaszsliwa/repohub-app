class Git::Repository < ActiveResource::Base
  self.site = "http://git.repohub.dev/repositories"

  has_many :commits
end