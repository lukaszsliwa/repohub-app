class AddChangesToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :total_changes, :integer, default: 0
  end
end
