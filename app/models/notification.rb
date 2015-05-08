class Notification < ActiveRecord::Base
  belongs_to :repository
  belongs_to :space
  belongs_to :user

  default_scope -> { order('id desc') }

  after_validation :cache_name

  def resource
    @resource ||= case resource_name
    when 'Branch' ; branch
    when 'Tag'    ; tag
    when 'Commit' ; commit
    else nil
    end
  end

  def cache_name
    self.cached_name = resource.try(:name) || resource.try(:sha)
  end

  def branch
    @branch ||= repository.branches.find_by_id(resource_id)
  end

  def tag
    @tag ||= repository.tags.find_by_id(resource_id)
  end

  def commit
    @commit ||= repository.commits.find_by_id(resource_id)
  end

  def repository_commit_create?
    annotation == 'repository:commit:create'
  end

  def repository_branch_create?
    annotation == 'repository:branch:create'
  end

  def repository_branch_destroy?
    annotation == 'repository:branch:destroy'
  end

  def repository_tag_destroy?
    annotation == 'repository:tag:destroy'
  end

  def repository_tag_create?
    annotation == 'repository:tag:create'
  end

  def repository_user_destroy?
    annotation == 'repository:user:destroy'
  end

  def repository_user_create?
    annotation == 'repository:user:create'
  end

  def repository_destroy?
    annotation == 'repository:destroy'
  end

  def repository_create?
    annotation == 'repository:create'
  end

  def repository_branch?
    annotation =~ /\Arepository\:branch\:/
  end

  def repository_tag?
    annotation =~ /\Arepository\:tag\:/
  end

  def repository_commit?
    annotation =~ /\Arepository\:commit\:/
  end
end
