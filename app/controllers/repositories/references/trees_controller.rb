class Repositories::References::TreesController < Repositories::References::ApplicationController
  def show
    @commits = @reference.commits
  end
end
