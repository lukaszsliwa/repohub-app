class Repositories::References::BlobsController < Repositories::References::ApplicationController
  def show
    @blob = @reference.resolve_object params[:path]
  end
end
