class Callbacks::Resources::ApplicationController < ApplicationController
  skip_before_filter :verify_authenticity_token

  skip_before_action :authenticate_user!
  skip_before_filter :find_space

  before_filter :server_user
  before_filter :find_repository

  def server_user
    @user = User.find_by_username! params[:username]
  end

  def find_repository
    @repository = Repository.find params[:callback_id]
  end
end
