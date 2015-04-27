class Git::Repository::Tree::Blob < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id/trees/:tree_id"

  belongs_to :tree, class_name: 'Git::Repository::Tree'

  def folders
    unless !!@folders
      @tmp_paths, parts = [], path.split('/')
      @folders = parts.map do |part|
        @tmp_paths << part
        path = @tmp_paths.join '/'
        OpenStruct.new(name: part, path: path)
      end
      @folders.pop
    end
    @folders
  end

  def lines
    content.lines.each_with_index.map do |content, number|
      OpenStruct.new(number: number + 1, content: content)
    end
  end
end