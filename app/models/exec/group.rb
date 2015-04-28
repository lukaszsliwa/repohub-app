class Exec::Group < ActiveResource::Base
  self.site = Settings.exec.url
end