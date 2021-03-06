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
  has_many :notifications, dependent: :nullify
  has_many :comments, dependent: :destroy

  has_many :user_repository_subscriptions, dependent: :destroy
  has_many :subscribers, through: :user_repository_subscriptions, source: :user

  after_commit :execute_remote_callbacks_on_create,  on: :create
  after_commit :on_create_notification, on: :create
  after_commit :on_destroy_notification, on: :destroy
  after_commit :execute_remote_callbacks_on_destroy, on: :destroy

  delegate :size, to: :git, allow_nil: true

  scope :space, ->(space) { where("repositories.space_id = ?", space.try(:id)) }

  mount_uploader :logo, LogoUploader

  def commits_in_tree(sha = nil, page = nil, limit = nil)
    page ||= 1
    limit ||= 32
    params = { repository_id: id, offset: (page.to_i-1) * limit.to_i, limit: limit.to_i }
    params[:sha] = sha if sha
    git_repository_commits = Git::Repository::Commit.all(params: params)
    commits.where(sha: git_repository_commits.map(&:sha))
  end

  def handle_with_space
    space.present? ? [space.handle, handle].join('/') : handle
  end

  def execute_remote_callbacks_on_create
    Exec::Client::Repository.new(db_id: id).save
  end

  def execute_remote_callbacks_on_destroy
    Exec::Client::Repository.delete id
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

  def create_commits(from, to, server_user)
    params = { repository_id: id, from: from, to: to}.delete_if {|key, value| value.nil? }
    Commit.transaction do
      Git::Repository::Commit.all(params: params).to_a.reverse.each do |git_repository_commit|
        commits.create(sha: git_repository_commit.sha, user_id: server_user.id, additions: git_repository_commit.additions, deletions: git_repository_commit.deletions)
      end
    end
  end

  def on_create_notification
    Notification.create!(annotation: 'repository:create', space_id: space_id, repository_id: id, user_id: created_by_id, resource_name: 'Repository', resource_id: id)
  end

  def on_destroy_notification
    Notification.create!(annotation: 'repository:destroy', space_id: space_id, repository_id: id, user_id: created_by_id, resource_name: 'Repository', resource_id: id)
  end
end
