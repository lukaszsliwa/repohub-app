class Repositories::Branches::CallbacksController < Repositories::Branches::ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def create
    @branch.synchronize(server_user, params[:old_rev], params[:new_rev])
    render nothing: true
  end

  def destroy
    @branch.destroy
    render nothing: true
  end
end
