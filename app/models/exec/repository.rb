class Exec::Repository < ActiveResource::Base
  self.site = Settings.exec.url
end