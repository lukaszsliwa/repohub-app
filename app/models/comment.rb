class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commit, counter_cache: :comments_count
  belongs_to :repository

  validates :content, presence: true

  after_commit :on_create_notification,  on: :create

  def on_create_notification
    Notification.create!(annotation: 'repository:comment:create', space_id: repository.space_id, repository_id: repository_id, user_id: user_id, resource_name: 'Comment', resource_id: id)
  end
end
