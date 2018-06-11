class RemoveEmailFromCommits < ActiveRecord::Migration
  def change
    remove_column :commits, :email, :string
  end
end
