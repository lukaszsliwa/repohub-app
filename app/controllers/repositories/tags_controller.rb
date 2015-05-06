class Repositories::TagsController < Repositories::ApplicationController
  def index
    @tags = @repository.tags.all
  end

  def show
    @tag = @tree = Git::Repository::Tag.find params[:id], params: { repository_id: @repository.id }
    @commit = Git::Repository::Commit.find :one, from: :first, params: { repository_id: @repository.id, sha: @tag.sha }
    @contents =  Git::Repository::Tree::Content.all params: { repository_id: @repository.id, tree_id: @tag.sha }
  end
end
