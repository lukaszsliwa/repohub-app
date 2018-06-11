class Repositories::CommitsController < Repositories::ApplicationController
  def index
    @commits ||= @repository.commits_in_tree(nil, params[:page], 32)
  end

  def show
    @tree = @commit = @repository.commits.find_by_sha!(params[:id])
    @comments = @commit.comments
  end
end
