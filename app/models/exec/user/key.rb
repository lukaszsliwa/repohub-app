class Exec::User::Key < ActiveResource::Base
  self.site = "#{Settings.exec.url}/users/:user_id"
end