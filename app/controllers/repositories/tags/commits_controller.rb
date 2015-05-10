class Repositories::Tags::CommitsController < Repositories::Tags::ApplicationController
  def index
    @commits ||= @repository.commits_in_tree @tag.sha

    render template: 'repositories/commits/index'
  end
end
