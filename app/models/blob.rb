class Blob < Struct.new('Blob', :name, :sha, :mode)
  def message
  end
end