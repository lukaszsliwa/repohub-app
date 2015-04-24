class Repositories::Trees::ApplicationController < Repositories::ApplicationController
  before_filter :find_tree

  def find_tree
    @tree = Git::Repository::Tree.find(params[:tree_id], params: { repository_id: params[:repository_id] })
  end
end


