class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_readonly :username

  before_validation :validate_server_user, on: :create
  before_validation :generate_password, on: :create
  after_create  :server_command_add_user
  after_destroy :server_command_delete_user

  has_many :keys, dependent: :destroy
  has_many :repository_users, dependent: :destroy
  has_many :repositories, through: :repository_users

  mount_uploader :avatar, AvatarUploader

  def generate_password
    self.password = Devise.friendly_token.first 32
  end

  def validate_server_user
    unless `getent passwd #{username}`.blank?
      self.errors[:username] << 'is incorrect or limited by the system'
    end
  end

  def server_command_add_user
    Rails.logger.info `#{Rails.root}/bin/application/user/create.sh #{username}`
  end

  def server_command_delete_user
    Rails.logger.info `#{Rails.root}/bin/application/user/destroy.sh #{username}`
  end
end
