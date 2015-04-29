require_dependency 'exec/group/user'
require_dependency 'exec/repository/group/user'

class Repository < ActiveRecord::Base
  attr_readonly :handle

  belongs_to :created_by, class_name: 'User'
  belongs_to :space

  validates :name, :handle, presence: true
  validates :handle, uniqueness: true

  before_create :initialize_handle

  has_many :repository_users, dependent: :destroy
  has_many :users, through: :repository_users
  has_many :commits, dependent: :destroy
  has_many :branches, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :references, dependent: :destroy

  after_commit :execute_remote_callbacks_on_create,  on: :create
  after_commit :execute_remote_callbacks_on_destroy, on: :destroy

  delegate :size, to: :git, allow_nil: true

  scope :space, ->(space) { where(space_id: space.try(:id)) }

  def execute_remote_callbacks_on_create
    git_repository_create
    exec_group_create
    exec_group_user_create
    exec_repository_owner_create
  end

  def git_repository_create
    git_repository = Git::Repository.new(name: self.handle)
    git_result = git_repository.save
    git_repository.errors.full_messages.each do |message|
      errors.add :base, message
    end
    git_result
  end

  def exec_group_create
    Exec::Group.new(id: id).save
  end

  def exec_group_user_create
    Exec::Group::User.find('git', params: {group_id: id}).post :link
  end

  def exec_repository_owner_create
    Exec::Repository::Group::User.find('git', params: {repository_id: handle, group_id: id}).post :owner
  end

  def execute_remote_callbacks_on_destroy
    exec_repository_destroy
    exec_group_destroy
    exec_repository_owner_destroy
  end

  def exec_repository_destroy
    Exec::Repository.delete(self.handle)
  end

  def exec_group_destroy
    Exec::Group.delete id
  end

  def path
    Settings.git.repository.path % {name: handle}
  end

  def synchronize_commits_between(rev, current_rev, by)
    walker = Rugged::Walker.new(git)
    walker.push(current_rev)
    walker.hide(rev) if rev != '0000000000000000000000000000000000000000'
    walker.to_a.reverse.each do |walker_commit|
      commits.create_with(user: by).find_or_create_by(sha: walker_commit.oid)
    end
  end

  def git
    @git ||= Git::Repository.find(handle) rescue nil
  end

  def initialize_handle
    self.handle = name.parameterize if self.handle.blank?
  end

  def to_param
    handle
  end
end
