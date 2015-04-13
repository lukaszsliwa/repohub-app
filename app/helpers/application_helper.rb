require 'github/markup'

module ApplicationHelper
  def render_readme(reference, path)
    readme = reference.files(path).map(&:name).find {|file| file =~ /\AREADME\./}
    if readme.present?
      readme_path = path.present? ? "#{path}/#{readme}" : readme
      content = reference.resolve_object(readme_path).content.lines.join
      GitHub::Markup.render(readme, content).html_safe
    end
  end
end
