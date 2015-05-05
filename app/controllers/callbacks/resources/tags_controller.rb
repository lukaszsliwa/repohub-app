class Callbacks::Resources::TagsController < Callbacks::Resources::ApplicationController
  def create
    @repository.tags.find_or_create_by(name: params[:resource_id], created_by: server_user)
    render nothing: true
  end

  def destroy
    @tag = @repository.tags.find_by_name!(params[:resource_id])
    @tag.deleted_by = server_user
    @tag.destroy
    render nothing: true
  end
end
