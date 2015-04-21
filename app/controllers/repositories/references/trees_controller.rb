class Repositories::References::TreesController < Repositories::References::ApplicationController
  def show
    @commits = @reference.commits.all
  end
end
