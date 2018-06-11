class SpacesController < ApplicationController
  def index
    @spaces = Space.all
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new params_space

    respond_to do |format|
      if @space.save
        format.html { redirect_to spaces_path }
      else
        format.html { render action: :new }
      end
    end
  end

  def show
    @space = Space.find_by_handle! params[:id]
    @notifications = @space.notifications.page(params[:page])
  end

  def edit
    @space = Space.find_by_handle! params[:id]
  end

  def update
    @space = Space.find_by_handle! params[:id]
  end

  def destroy
    @space = Space.find_by_handle! params[:id]
  end

  private

  def params_space
    params[:space].permit(:id, :name, :handle)
  end
end