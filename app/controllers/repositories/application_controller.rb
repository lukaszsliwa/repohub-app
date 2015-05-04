class Repositories::ApplicationController < ApplicationController
  before_filter :find_repository

  def find_repository
    @repository = current_user.repositories.space(@space).find_by_handle! params[:repository_id]
  end
end
