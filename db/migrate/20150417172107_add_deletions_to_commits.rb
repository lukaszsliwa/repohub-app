class AddDeletionsToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :deletions, :integer, default: 0
  end
end
