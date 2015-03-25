class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :generate_password, on: :create
  after_create  :server_command_add_user
  after_destroy :server_command_delete_user

  has_many :repository_users, dependent: :destroy
  has_many :repositories, through: :repository_users

  mount_uploader :avatar, AvatarUploader

  def generate_password
    self.password = Devise.friendly_token.first 32
  end

  def server_command_add_user
    `#{Settings.server.user.add.exec % {login: username}}`
  end

  def server_command_delete_user
    `#{Settings.server.user.delete.exec % {login: username}}`
  end
end
