class Key < ActiveRecord::Base
  belongs_to :user

  after_commit :generate_authorized_keys

  validates :name, :value, presence: true

  def generate_authorized_keys
    #`echo "#{content}" > /home/#{user.username}/.ssh/authorized_keys`
    File.open("/home/#{user.username}/.ssh/authorized_keys", 'w') do |file|
      file.write "# Generated at #{DateTime.now}\n"
      user.keys.all.map do |key|
        file.write "# key-#{key.id}\n#{key.value}\n\n"
      end
    end
  end
end
