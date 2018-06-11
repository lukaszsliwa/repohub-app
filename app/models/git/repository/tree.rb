class Git::Repository::Tree < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id"

  has_many :contents, class_name: 'Git::Repository::Tree::Content'

  attr_accessor :path

  def folders
    return [] if path.nil?
    unless !!@folders
      @tmp_paths, parts = [], path.split('/')
      @folders = parts.map do |part|
        @tmp_paths << part
        path = @tmp_paths.join '/'
        OpenStruct.new(name: part, path: path)
      end
    end
    @folders
  end

  def self.use_relative_model_naming?
    true
  end
end