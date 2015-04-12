class Repositories::Branches::BlobsController < Repositories::Branches::ApplicationController
  def show
    @blob = @branch.resolve_object params[:path]
  end
end
