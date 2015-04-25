class Git::Repository::Tree::Blob < ActiveResource::Base
  self.site = "#{Settings.git.url}/repositories/:repository_id/trees/:tree_id"

  belongs_to :tree, class_name: 'Git::Repository::Tree'


  def lines
    content.lines.each_with_index.map do |content, number|
      OpenStruct.new(number: number + 1, content: content)
    end
  end
end