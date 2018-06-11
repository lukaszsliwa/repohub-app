class Callbacks::Resources::BranchesController < Callbacks::Resources::ApplicationController
  def create
    @repository.branches.create_with(created_by: server_user).find_or_create_by(name: params[:resource_id])
    render nothing: true
  end

  def destroy
    @branch = @repository.branches.find_by_name!(params[:resource_id])
    @branch.deleted_by = server_user
    @branch.destroy
    render nothing: true
  end
end
