class Repositories::TagsController < Repositories::ApplicationController
  def index
    @tags = @repository.tags.all
  end

  def show
    @tag = @tree = Git::Repository::Tag.find params[:id], params: { repository_id: @repository.id }
    @commits = Git::Repository::Tag::Commit.all params: { repository_id: @repository.id, tag_id: @tag.sha }
    @contents =  Git::Repository::Tree::Content.all params: { repository_id: @repository.id, tree_id: @tag.sha }
  end
end
