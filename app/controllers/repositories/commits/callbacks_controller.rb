class Repositories::Commits::CallbacksController < Repositories::Commits::ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  def create
    @repository.synchronize_commits_between params[:old], params[:new], server_user
    render nothing: true
  end

  private

  def server_user
    @user = User.find_by_username! params[:username]
  end
end
