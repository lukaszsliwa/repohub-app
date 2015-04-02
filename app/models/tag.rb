class Tag < Reference
  def commits
    walker = Rugged::Walker.new(repository.git)
    walker.push repository.git.tags[name].target_id
    walker
  end

  def contents
    repository.git.tags[name].target.tree.map do |entry|
      OpenStruct.new(name: entry[:name], type: entry[:type], id: entry[:oid], blob?: entry[:type] == :blob)
    end
  end
end