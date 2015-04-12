class Branch < Reference
  def ref
    git.branches[name]
  end
end