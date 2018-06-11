class AddBranchIdToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :branch_id, :integer
    add_index :commits, :branch_id
  end
end
