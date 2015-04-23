class Repositories::References::TreesController < Repositories::References::ApplicationController
  def show
    @commits = Git::Commit.all params: { repository_id: @repository.handle }
    @contents = Git::Content.all params: { id: params[:path], repository_id: @repository.handle, tree_id: @reference.sha }
  end
end
