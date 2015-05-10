class Repositories::Tags::CommitsController < Repositories::Tags::ApplicationController
  def index
    @commits ||= @repository.commits_in_tree(@tag.sha, params[:page], 32)

    render template: 'repositories/commits/index'
  end
end
