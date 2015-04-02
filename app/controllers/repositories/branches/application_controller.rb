class Repositories::Branches::ApplicationController < Repositories::ApplicationController
  before_filter :find_branch

  def find_branch
    @branch ||= @repository.branches.find_or_create_by(name: params[:branch_id])
  end

  def server_user
    @server_user ||= User.find_by_username(params[:username])
  end
end
