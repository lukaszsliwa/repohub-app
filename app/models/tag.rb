class Tag < Reference
  def sha
    @sha ||= git.sha
  end

  def git
    Git::Tag.find name, params: { repository_id: repository.handle }
  end
end