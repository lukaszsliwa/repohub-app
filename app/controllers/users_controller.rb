class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params_user

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path }
      else
        format.html { render action: :new }
      end
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    respond_to do |format|
      if @user.update_attributes params_user
        format.html { redirect_to users_path }
      else
        format.html { render action: :edit }
      end
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy

    redirect_to users_path
  end

  private

  def params_user
    params[:user].permit(:full_name, :username, :email, :password, :password_confirmation, :avatar)
  end
end
