class Repositories::Tags::ApplicationController < Repositories::ApplicationController
  before_filter :find_tag

  def find_tag
    @tag = Git::Repository::Tag.find(params[:tag_id], params: { repository_id: @repository.id })
  end
end


