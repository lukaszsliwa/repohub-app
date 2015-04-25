class Repositories::Trees::RawsController < Repositories::Trees::ApplicationController
  def show
    @blob = Git::Repository::Tree::Blob.find params[:id], params: { repository_id: params[:repository_id], tree_id: params[:tree_id] }

    send_data @blob.content, disposition: 'inline', filename: @blob.name
  end
end