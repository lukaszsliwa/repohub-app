class Branch < Reference
  def ref
    git.branches[name]
  end

  def sha
    @sha ||= git.sha
  end

  def git
    Git::Branch.find name, params: { repository_id: repository.handle }
  end
end