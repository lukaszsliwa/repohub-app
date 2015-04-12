class Repositories::Branches::CommitsController < Repositories::Branches::ApplicationController
  def index
  end

  def show
    @commit = @branch.git.lookup params[:id]
    @diff = @commit.parents[0].diff @commit
  end
end
