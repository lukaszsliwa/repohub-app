class Key < ActiveRecord::Base
  belongs_to :user

  after_commit :generate_authorized_keys

  validates :name, :value, presence: true

  def generate_authorized_keys
    Exec::Client::Key.create(user_id: user.username, keys: user.keys.map { |key| key.attributes })
  end
end
