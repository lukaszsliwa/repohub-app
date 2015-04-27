class Git::Repository < ActiveResource::Base
  self.site = Settings.git.url

  has_many :commits, class_name: 'Git::Repository::Commit'
  has_many :branches, class_name: 'Git::Repository::Branch'
  has_many :tags, class_name: 'Git::Repository::Tag'

  delegate :users, :name, :description, :commits_count, to: :app

  def app
    @app ||= ::Repository.find_by_handle(id)
  end
end