class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new params_repository
    @repository.created_by = current_user

    respond_to do |format|
      if @repository.save
        format.html { redirect_to repositories_path, notice: 'Repository was successfully created.' }
      else
        format.html { render action: :new }
      end
    end
  end

  def show
    @repository = Repository.find_by_handle params[:id]
  end

  def edit
    @repository = Repository.find_by_handle params[:id]
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
    @repository = Repository.find_by_handle params[:id]

    @repository.destroy

    redirect_to repositories_path
  end

  private


  def params_repository
    params[:repository].permit(:id, :name, :handle, :description)
  end
end
