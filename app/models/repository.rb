class Repository < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'

  validates :name, :handle, presence: true
  validates :handle, uniqueness: true

  before_create :initialize_handle

  has_many :repository_users, dependent: :destroy
  has_many :users, through: :repository_users

  def self.type(name)
    case name
    when 'Repository::Git' ; Repository::Git
    else
      Repository
    end
  end

  def initialize_handle
    self.handle = name.parameterize if self.handle.blank?
  end

  def to_param
    handle
  end
end
