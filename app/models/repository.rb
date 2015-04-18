class Repository < ActiveRecord::Base
  attr_readonly :handle

  belongs_to :created_by, class_name: 'User'

  validates :name, :handle, presence: true
  validates :handle, uniqueness: true

  before_create :initialize_handle

  has_many :repository_users, dependent: :destroy
  has_many :users, through: :repository_users
  has_many :commits, dependent: :destroy
  has_many :branches, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :references, dependent: :destroy

  def self.type(name)
    case name
    when 'GitRepository' ; GitRepository
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
