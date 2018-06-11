class Repositories::Commits::CommentsController < Repositories::Commits::ApplicationController
  def create
    @comment = @commit.comments.build params_comment
    @comment.sha = @commit.sha
    @comment.user = current_user
    @comment.repository = @repository
    @comment.save
  end

  private

  def params_comment
    params[:comment].permit(:id, :path, :position, :content)
  end
end