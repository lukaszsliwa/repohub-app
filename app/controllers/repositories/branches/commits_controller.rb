class Repositories::Branches::CommitsController < Repositories::Branches::ApplicationController
  def index
    @commits ||= @repository.commits_in_tree(@branch.sha, params[:page], 32)

    render template: 'repositories/commits/index'
  end
end
