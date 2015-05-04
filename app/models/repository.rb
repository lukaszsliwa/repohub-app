require_dependency 'exec/repository/user'

class Repository < ActiveRecord::Base
  attr_readonly :handle

  belongs_to :created_by, class_name: 'User'
  belongs_to :space

  validates :name, :handle, presence: true
  validates :handle, uniqueness: {scope: :space_id}

  before_create :initialize_handle

  has_many :repository_users, dependent: :destroy
  has_many :users, through: :repository_users
  has_many :commits, dependent: :destroy
  has_many :branches, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :references, dependent: :destroy

  after_commit  :execute_remote_callbacks_on_create,  on: :create
  before_destroy :execute_remote_callbacks_on_destroy, on: :destroy

  delegate :size, to: :git, allow_nil: true

  scope :space, ->(space) { where("repositories.space_id = ?", space.try(:id)) }

  def handle_with_space
    space.present? ? [space.handle, handle].join('/') : handle
  end

  def execute_remote_callbacks_on_create
    git_repository_create
    exec_repository_create
    exec_repository_owner
  end

  def git_repository_create
    git_repository = Git::Repository.new(name: id)
    git_repository.prefix_options[:space_id] = space_id
    git_result = git_repository.save
    git_repository.errors.full_messages.each do |message|
      errors.add :base, message
    end
    git_result
  end

  def exec_repository_create
    Exec::Repository.new(db_id: id).save
  end

  def exec_repository_owner
    Exec::Repository::User.find('git', params: {repository_id: id}).post :owner
  end

  def execute_remote_callbacks_on_destroy
    exec_repository_destroy
  end

  def exec_repository_destroy
    Exec::Repository.delete id
  end

  def git
    @git ||= Git::Repository.find(id) rescue nil
  end

  def initialize_handle
    self.handle = name.parameterize if self.handle.blank?
  end

  def to_param
    handle
  end
end
