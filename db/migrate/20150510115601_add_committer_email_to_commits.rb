class AddCommitterEmailToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :committer_email, :string
  end
end
