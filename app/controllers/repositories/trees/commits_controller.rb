class Repositories::Trees::CommitsController < Repositories::Trees::ApplicationController
  def index
    @commits ||= @repository.commits_in_tree @tree.sha

    render template: 'repositories/commits/index'
  end
end
