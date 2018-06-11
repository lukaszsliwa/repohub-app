class AccountsController < ApplicationController
  def show
    @account = current_user
  end

  def update
    @account = current_user
    respond_to do |format|
      if @account.update_attributes params_account
        format.html { redirect_to account_path, notice: 'Account was updated.' }
      else
        format.html { render action: :show }
      end
    end
  end

  private

  def params_account
    params[:account].permit(:full_name, :email, :avatar, :remove_avata, :avatar_cache)
  end
end