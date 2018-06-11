class RemoveBranchToCommits < ActiveRecord::Migration
  def change
    remove_column :commits, :branch, :string
  end
end
