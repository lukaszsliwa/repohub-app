class RepositoriesController < ApplicationController
  before_filter :find_repository, only: [:show, :edit, :destroy]

  def index
    @repositories = current_user.repositories.all
  end

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new params_repository
    @repository.created_by = current_user

    respond_to do |format|
      if @repository.save
        @repository.users << current_user
        format.html { redirect_to repositories_path, notice: 'Repository was successfully created.' }
      else
        format.html { render action: :new }
      end
    end
  end

  def show
    @notifications = @repository.notifications.page params[:page]
  end

  def edit
  end

  def update
    @repository = Repository.find params[:repository][:id]

    respond_to do |format|
      if @repository.update_attributes params_repository
        format.html { redirect_to repositories_path }
      else
        format.html { render action: :edit }
      end
    end
  end

  def destroy
    @repository.destroy

    redirect_to repositories_path
  end

  private

  def params_repository
    params[:repository].permit(:id, :name, :handle, :description, :space_id, :logo)
  end

  def find_repository
    @repository = current_user.repositories.space(@space).find_by_handle! params[:id]
  end
end
