class Repositories::References::CallbacksController < Repositories::References::ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  skip_before_filter :find_reference

  before_filter :find_or_create_reference

  def create
    @reference.synchronize_commits_between(params[:old], params[:new], server_user)
    render nothing: true
  end

  def destroy
    @reference.destroy

    render nothing: true
  end

  private

  def find_or_create_reference
    @reference = @repository.references.find_or_create_by(type: params[:reference_type].classify, name: params[:reference_id])
  end

  def server_user
    @user = User.find_by_username! params[:username]
  end
end
