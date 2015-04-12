class Repositories::References::ApplicationController < Repositories::ApplicationController
  before_filter :find_reference

  def find_reference
    @reference = @repository.references.where(type: params[:reference_type].classify).find_by_name! params[:reference_id]
  end

  def server_user
    @server_user ||= User.find_by_username(params[:username])
  end
end
