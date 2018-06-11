class Repositories::Branches::ApplicationController < Repositories::ApplicationController
  before_filter :find_branch

  def find_branch
    @branch = Git::Repository::Branch.find(params[:branch_id], params: { repository_id: @repository.id })
  end
end


