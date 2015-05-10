class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_readonly :username

  before_validation :validate_server_user, on: :create
  before_validation :generate_password, on: :create

  has_many :keys, dependent: :destroy
  has_many :repository_users, dependent: :destroy
  has_many :repositories, through: :repository_users

  has_many :user_notifications, dependent: :destroy
  has_many :notifications, through: :user_notifications
  has_many :repository_subscriptions, class_name: 'UserRepositorySubscription', dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def notify(notification_id)
    user_notifications.create(notification_id: notification_id)
  end

  def subscribes?(repository_id)
    @repository_subscription ||= repository_subscriptions.find_by_repository_id(repository_id)
  end

  def generate_password
    self.password = Devise.friendly_token.first 32
  end
end
