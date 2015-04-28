class Exec::Group::User < ActiveResource::Base
  self.site = "#{Settings.exec.url}/groups/:group_id"
end