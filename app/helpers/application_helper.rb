module ApplicationHelper
  def current_reference
    if (name = @branch.try(:name) || @tag.try(:name)).nil?
      sha = @commit.try(:sha) || @tree.try(:sha)
      name = truncate(sha, length: 8, omission: '') if sha
    end
    name
  end

  def language_css_class_for(filename)
    case File.extname(filename)
    when '.rb' ; 'ruby'
    when '.haml' ; 'haml'
    when '.scss' ; 'scss'
    when '.css' ; 'css'
    when '.html' ; 'html'
    else 'not-recognized-file'
    end
  end
end
