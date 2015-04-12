class Repositories::Tags::CallbacksController < Repositories::Tags::ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  def create
    render nothing: true
  end

  def destroy
    @tag.destroy

    render nothing: true
  end
end
