class Key < ActiveRecord::Base
  belongs_to :user

  after_commit :generate_authorized_keys

  validates :name, :value, presence: true

  def generate_authorized_keys

  end
end
