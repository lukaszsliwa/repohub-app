class Repositories::BranchesController < Repositories::ApplicationController
  def index
    @branches = @repository.branches.all
  end

  def show
    @branch = @tree = Git::Repository::Branch.find params[:id], params: { repository_id: params[:repository_id] }
    @commits = Git::Repository::Branch::Commit.all params: { repository_id: params[:repository_id], branch_id: @branch.sha }
    @contents =  Git::Repository::Tree::Content.all params: { repository_id: params[:repository_id], tree_id: @branch.sha }
  end
end
