class Notification < ActiveRecord::Base
  belongs_to :repository
  belongs_to :space
  belongs_to :user

  validates :message, presence: true

  default_scope -> { order('id desc') }
end
