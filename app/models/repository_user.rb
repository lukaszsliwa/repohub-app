class RepositoryUser < ActiveRecord::Base
  belongs_to :repository
  belongs_to :user

  after_create  :server_command_after_create
  after_destroy :server_command_after_destroy

  def server_command_after_create
    Rails.logger.info `#{Rails.root}/bin/application/repository_user/create.sh #{user.username} #{repository.handle} #{repository.id}`
  end

  def server_command_after_destroy
    Rails.logger.info `#{Rails.root}/bin/application/repository_user/destroy.sh #{user.username} #{repository.handle} #{repository.id}`
  end
end
