class Repositories::Trees::CommitsController < Repositories::Trees::ApplicationController
  def index
    @commits = Git::Repository::Commit.all params: { repository_id: @repository.id, sha: @tree.sha }

    render template: 'repositories/commits/index'
  end
end
