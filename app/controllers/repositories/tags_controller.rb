class Repositories::TagsController < Repositories::ApplicationController
  def show
    @tag = @reference = @repository.tags.find_by_name! params[:id]
  end
end