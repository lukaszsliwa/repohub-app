class Branch < Reference
  def commits
    walker = Rugged::Walker.new(repository.git)
    walker.push repository.git.branches[name].target_id
    walker
  end

  def contents
    repository.git.branches[name].target.tree.map do |entry|
      OpenStruct.new(name: entry[:name], type: entry[:type], id: entry[:oid], blob?: entry[:type] == :blob)
    end
  end
end