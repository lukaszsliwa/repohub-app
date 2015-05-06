class Repositories::Trees::ContentsController < Repositories::Trees::ApplicationController
  def index
    show
  end

  def show
    @tree.path = params[:id]
    @commit = Git::Repository::Commit.find :one, from: :first, params: { repository_id: @repository.id, sha: params[:tree_id] }
    @contents = Git::Repository::Tree::Content.all params: { id: params[:id], repository_id: @repository.id, tree_id: params[:tree_id] }
  end
end