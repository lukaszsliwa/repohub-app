class Repositories::CommitsController < Repositories::ApplicationController
  def index
  end

  def show
    @tree = @commit = Git::Repository::Commit.find params[:id], params: { repository_id: @repository.id }
  end
end
