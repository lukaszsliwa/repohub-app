class AddCommitterNameToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :committer_name, :string
  end
end
