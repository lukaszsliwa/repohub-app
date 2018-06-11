class Git::Repository::Branch < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id"

  belongs_to :repository, class_name: 'Git::Repository'

  has_many :commits, class_name: 'Git::Repository::Branch::Commit'
  has_many :contents, class_name: 'Git::Repository::Branch::Content'

  def folders
    []
  end

  def self.use_relative_model_naming?
    true
  end
end