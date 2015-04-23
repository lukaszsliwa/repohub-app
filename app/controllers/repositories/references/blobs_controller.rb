class Repositories::References::BlobsController < Repositories::References::ApplicationController
  def show
    @blob = Git::Blob.find params[:path], params: { repository_id: @repository.handle, tree_id: @reference.sha }
  end
end
