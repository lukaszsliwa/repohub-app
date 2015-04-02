class Repositories::CallbacksController < Repositories::ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @repository.synchronize
  end
end
