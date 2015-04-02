class Repositories::Tags::ApplicationController < Repositories::ApplicationController
  before_filter :find_tag

  def find_tag
    @tag ||= @repository.tags.find_or_create_by(name: params[:tag_id])
  end

  def server_user
    @server_user ||= User.find_by_username(params[:username])
  end
end
