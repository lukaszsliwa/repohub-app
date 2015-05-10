class RemoveAuthorFromCommits < ActiveRecord::Migration
  def change
    remove_column :commits, :author, :string
  end
end
