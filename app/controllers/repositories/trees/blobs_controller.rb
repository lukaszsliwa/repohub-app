class Repositories::Trees::BlobsController < Repositories::Trees::ApplicationController
  def index
    show
  end

  def show
    @blob = Git::Repository::Tree::Blob.find params[:id], params: { repository_id: params[:repository_id], tree_id: params[:tree_id] }
  end
end