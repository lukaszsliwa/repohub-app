module ApplicationHelper
  def create_content_path_from(repository, reference, content, current_path = nil)
    path = current_path.nil? ? content.name : File.join(current_path, content.name)
    if reference.type == 'Branch'
      repository_branch_browser_path(repository, reference, path: path)
    else
      repository_tag_browser_path(repository, reference, path: path)
    end
  end
end
