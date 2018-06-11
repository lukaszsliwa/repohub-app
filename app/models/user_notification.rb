class UserNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification

  validates :user_id, uniqueness: {scope: :notification_id}
end
