class DashboardsController < ApplicationController
  def show
    @notifications = current_user.notifications.page(params[:page])
  end
end