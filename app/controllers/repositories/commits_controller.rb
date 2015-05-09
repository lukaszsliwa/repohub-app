class Repositories::CommitsController < Repositories::ApplicationController
  def index
    @commits = Git::Repository::Commit.all params: { repository_id: @repository.id }
  end

  def show
    @tree = @commit = Git::Repository::Commit.find params[:id], params: { repository_id: @repository.id }
    @comments = @repository.commits.find_by_sha!(params[:id]).comments
  end
end
