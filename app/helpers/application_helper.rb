module ApplicationHelper
  def current_reference
    if (name = @branch.try(:name) || @tag.try(:name)).nil?
      sha = @commit.try(:sha) || @tree.try(:sha)
      name = truncate(sha, length: 8, omission: '') if sha
    end
    name
  end
end
