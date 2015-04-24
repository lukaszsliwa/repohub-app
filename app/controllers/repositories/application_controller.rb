class Repositories::ApplicationController < ApplicationController
  before_filter :find_repository

  def find_repository
    @repository = Git::Repository.find params[:repository_id]
  end
end
