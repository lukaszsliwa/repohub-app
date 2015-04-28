class Exec::Repository::User < ActiveResource::Base
  self.site = "#{Settings.exec.url}/repositories/:repository_id"
end