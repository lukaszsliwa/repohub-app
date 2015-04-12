class Reference < ActiveRecord::Base
  belongs_to :repository

  delegate :git, to: :repository

  validates :name, presence: true

  def synchronize_commits_between(rev, current_rev, by)
    walker = Rugged::Walker.new(repository.git)
    walker.push(current_rev)
    walker.hide(rev) if rev != '0000000000000000000000000000000000000000'
    commits = walker.to_a
    walker.reset

    commits.reverse.each do |commit|
      repository.commits.create_with(user: by).find_or_create_by(sha: commit.oid)
    end
  end

  def commits(limit = 6, offset = 0)
    walker = Rugged::Walker.new(repository.git)
    walker.push ref.target_id
    walker

    Commit.where(sha: walker.each(limit: limit, offset: offset).map(&:oid))
  end

  def resolve_object(path)
    object = ref.target.tree
    if path
      hash = object.path path
      object = git.lookup(hash[:oid])
    end
    object
  end

  def contents(path = nil)
    tree = resolve_object(path)
    tree.map do |entry|
      entry_path = path.nil? ? entry[:name] : "#{path}/#{entry[:name]}"
      output = `cd #{repository.path} && git log -1 --format="%s%n%cr" #{ref.target_id} -- #{entry_path}`.split("\n")
      OpenStruct.new(name: entry[:name], type: entry[:type], id: entry[:oid], blob?: entry[:type] == :blob, message: output[0], modified: output[1])
    end
  end

  def folders(path = nil)
    contents(path).select { |content| !content.blob? }
  end

  def files(path = nil)
    contents(path).select &:blob?
  end

  def to_param
    name
  end
end
