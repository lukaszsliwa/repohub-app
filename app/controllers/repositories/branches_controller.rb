class Repositories::BranchesController < Repositories::ApplicationController
  def show
    @reference = @repository.branches.find_by_name params[:id]
  end
end