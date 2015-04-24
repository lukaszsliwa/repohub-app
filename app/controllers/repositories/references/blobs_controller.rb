class Repositories::References::BlobsController < Repositories::References::ApplicationController
  def show
    @blob = Git::Blob.find params[:path], params: { repository_id: @repository.to_param, tree_id: @reference.sha }
  end
end
