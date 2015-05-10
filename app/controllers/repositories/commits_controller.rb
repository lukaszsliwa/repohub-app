class Repositories::CommitsController < Repositories::ApplicationController
  def index
    @commits ||= @repository.commits_in_tree
  end

  def show
    @tree = @commit = Git::Repository::Commit.find params[:id], params: { repository_id: @repository.id }
    @comments = @repository.commits.find_by_sha!(params[:id]).comments
  end
end
