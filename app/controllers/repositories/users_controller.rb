class Repositories::UsersController < Repositories::ApplicationController
  before_filter :find_user, only: [:update, :destroy]

  def index
    @users = User.all
  end

  def update
    @user.repository_users.find_or_create_by(repository_id: @repository.id)
  end

  def destroy
    @user.repository_users.find_by_repository_id(@repository.id).destroy unless @repository.created_by == @user
  end

  private

  def find_user
    @user = User.find params[:id]
  end
end
