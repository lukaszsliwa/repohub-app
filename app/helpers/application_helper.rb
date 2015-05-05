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

  def notification_image_tag(annotation)
    case annotation
    when 'repository:create' ; image_tag('circles/rocket.png', width: '32px')
    when 'repository:destroy' ; image_tag('circles/denied.png', width: '32px')
    when 'repository_user:create' ; image_tag('circles/profle.png', width: '32px')
      when 'repository_user:destroy' ; image_tag('circles/denied.png', width: '32px')
      when 'repository:tag:create' ; image_tag('circles/tag.png', width: '32px')
      when 'repository:tag:destroy' ; image_tag('circles/denied.png', width: '32px')
      when 'repository:branch:create' ; image_tag('circles/merge.png', width: '32px')
      when 'repository:branch:destroy' ; image_tag('circles/denied.png', width: '32px')
      when 'repository:commit:create' ; image_tag('circles/upload.png', width: '32px')
    else nil
    end
  end
end
