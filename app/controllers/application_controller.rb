class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_filter :find_space

  def find_space
    @space = Space.find_by_handle params[:space_id] if params[:space_id]
  end
end
