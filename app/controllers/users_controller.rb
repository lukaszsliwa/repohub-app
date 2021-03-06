class UsersController < ApplicationController
  before_filter :find_user, only: :destroy

  def index
    @users = User.all
  end

  def create
  end

  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username! params[:id]
  end
end
