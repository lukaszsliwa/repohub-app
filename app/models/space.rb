class Space < ActiveRecord::Base
  validates :name, :handle, presence: true
  validates :handle, uniqueness: true

  has_many :repositories, dependent: :destroy
  has_many :notifications, dependent: :nullify

  after_validation :generate_handle

  def generate_handle
    self.handle = name.parameterize if self.handle.blank?
  end

  def to_param
    handle
  end
end
