class Repositories::SubscribesController < Repositories::ApplicationController
  def update
    current_user.repository_subscriptions.create(repository_id: @repository.id)
  end

  def destroy
    current_user.repository_subscriptions.find_by_repository_id!(@repository.id).destroy
  end
end
