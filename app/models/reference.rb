class Reference < ActiveRecord::Base
  belongs_to :repository

  validates :name, presence: true

  has_many :commits, dependent: :destroy

  def tree
    result = repository.git.ls_tree name
    puts result.inspect
    dirs = result['tree'].map do |name, values|
      Tree.new name, values[:sha], values[:mode]
    end
    files = result['blob'].map do |name, values|
      Blob.new name, values[:sha], values[:mode]
    end
    OpenStruct.new dirs: dirs, files: files
  end

  def to_param
    name
  end
end
