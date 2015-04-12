class Tag < Reference
  def ref
    repository.git.tags[name]
  end
end