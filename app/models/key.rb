class Key < ActiveRecord::Base
  belongs_to :user

  after_commit :generate_authorized_keys

  validates :name, :value, presence: true

  def generate_authorized_keys
    File.open("#{Rails.root}/public/authorized_keys/#{user.username}", "w") do |authorized_key|
      user.keys.each do |key|
        authorized_key.write "#key-#{key.id}\n#{key.value}\n\n"
      end
    end
  end
end
