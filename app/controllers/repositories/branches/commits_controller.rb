class Repositories::Branches::CommitsController < Repositories::Branches::ApplicationController
  def index
    @commits ||= @repository.commits_in_tree @branch.sha

    render template: 'repositories/commits/index'
  end
end
