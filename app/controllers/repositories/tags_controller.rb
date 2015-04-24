class Repositories::TagsController < Repositories::ApplicationController
  def index
    @tags = @repository.tags.all
  end

  def show
    @tag = @tree = Git::Repository::Tag.find params[:id], params: { repository_id: params[:repository_id] }
    @commits = Git::Repository::Tag::Commit.all params: { repository_id: params[:repository_id], tag_id: @tag.sha }
    @contents =  Git::Repository::Tree::Content.all params: { repository_id: params[:repository_id], tree_id: @tag.sha }
  end
end
