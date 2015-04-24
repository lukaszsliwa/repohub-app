class Git::Repository::Tag::Content < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id/tags/:tag_id"

  belongs_to :tag, class_name: 'Git::Repository::Tag'
end