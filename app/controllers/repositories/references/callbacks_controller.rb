class Repositories::References::CallbacksController < Repositories::References::ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  skip_before_filter :find_reference

  def create
    @repository.references.find_or_create_by(type: params[:reference_type].classify, name: params[:reference_id])
    render nothing: true
  end

  def destroy
    @repository.references.find_by_name!(params[:reference_id]).destroy
    render nothing: true
  end

  private

  def server_user
    @user = User.find_by_username! params[:username]
  end
end
