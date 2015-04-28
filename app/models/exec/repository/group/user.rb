class Exec::Repository::Group::User < ActiveResource::Base
  self.site = "#{Settings.exec.url}/repositories/:repository_id/groups/:group_id"
end