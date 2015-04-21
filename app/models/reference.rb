class Reference < ActiveRecord::Base
  belongs_to :repository

  delegate :git, to: :repository

  validates :name, presence: true

  def commits
    walker = Rugged::Walker.new(repository.git)
    walker.push ref.target_id

    shas = walker.to_a.map(&:oid)

    repository.commits.where(sha: shas).order('id desc')
  end

  def commits_by_user(from, to)
    since_attr = from.nil? ? '' : "--since='#{from.to_date} 00:00:00 +0000'"
    until_attr = to.nil? ? '' : "--until='#{to.to_date} 23:59:59 +0000'"
    output = `cd #{repository.path} && git shortlog -s -n #{since_attr} #{until_attr} #{name}`
    output.lines.map do |line|
      matcher = /\A([0-9]+)\t(.+)\z/.match line.strip
      OpenStruct.new(count: matcher[1].to_i, author: matcher[2])
    end
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
      output = `cd #{repository.path} && git log -1 --format="%s%n%cr%n%H" #{ref.target_id} -- #{entry_path}`.split("\n")
      OpenStruct.new(name: entry[:name], type: entry[:type], id: entry[:oid], blob?: entry[:type] == :blob, message: output[0], modified: output[1], sha: output[2])
    end
  end

  def folders(path = nil)
    @folders ||= contents(path).select { |content| !content.blob? }
  end

  def files(path = nil)
    @files ||= contents(path).select &:blob?
  end

  def to_param
    name
  end
end
