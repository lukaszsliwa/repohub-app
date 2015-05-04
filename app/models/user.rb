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
  has_many :notifications, dependent: :nullify

  mount_uploader :avatar, AvatarUploader

  def generate_password
    self.password = Devise.friendly_token.first 32
  end
end
