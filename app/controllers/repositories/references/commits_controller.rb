class Repositories::References::CommitsController < Repositories::References::ApplicationController
  def index
  end

  def show
    @commit = @reference.git.lookup params[:id]
    @diff = @commit.parents[0].diff @commit
  end
end
