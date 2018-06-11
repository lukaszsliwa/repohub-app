class Repositories::ApplicationController < ApplicationController
  before_filter :find_repository

  def find_repository
    scope = @space.nil? ? current_user.repositories : current_user.repositories.space(@space)
    @repository ||= scope.find_by_handle! params[:repository_id]
  end
end
