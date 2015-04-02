class Blob < Struct.new('Blob', :name, :sha, :mode)
  def message
    `git log -1 --format="%s" #{name}`
  end
end