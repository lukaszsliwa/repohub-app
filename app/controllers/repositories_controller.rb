class RepositoriesController < ApplicationController
  def index
    @repositories = Git::Repository.all.to_a
  end

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.type(params[:repository][:type]).new params_repository
    @repository.created_by = current_user

    respond_to do |format|
      if @repository.save
        current_user.repository_users.create(repository_id: @repository.id)
        format.html { redirect_to repositories_path, notice: 'Repository was successfully created.' }
      else
        format.html { render action: :new }
      end
    end
  end

  def show
    @repository = Repository.find_by_handle!(params[:repository_id] || params[:id])
    if (@branch = @repository.branches.first).present?
      redirect_to repository_branch_path(@repository, @branch)
    else
      render file: 'repositories/blank'
    end
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
    params[:repository].permit(:id, :name, :handle, :description, :type)
  end
end
