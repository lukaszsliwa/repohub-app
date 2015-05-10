class Repositories::Trees::CommitsController < Repositories::Trees::ApplicationController
  def index
    @commits ||= @repository.commits_in_tree(@tree.sha, params[:page], 32)

    render template: 'repositories/commits/index'
  end
end
