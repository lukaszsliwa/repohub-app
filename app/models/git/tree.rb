class Git::Tree < ActiveResource::Base
  self.site = "http://git.repohub.dev/repositories/:repository_id"

  has_many :contents, class_name: 'Git::Content'
end