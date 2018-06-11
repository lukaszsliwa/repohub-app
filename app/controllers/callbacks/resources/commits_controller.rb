class Callbacks::Resources::CommitsController < Callbacks::Resources::ApplicationController
  def create
    @repository.create_commits(params[:old], params[:new], server_user)
    render nothing: true
  end
end
