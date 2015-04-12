class Branch < Reference
  delegate :git, to: :repository

  def ref
    git.branches[name]
  end
end