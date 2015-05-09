class Repositories::Commits::ApplicationController < Repositories::ApplicationController
  before_filter :find_commit

  def find_commit
    @commit ||= @repository.commits.find_by_sha! params[:commit_id]
  end
end
