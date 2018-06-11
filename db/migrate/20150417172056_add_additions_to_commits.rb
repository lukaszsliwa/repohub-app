class AddAdditionsToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :additions, :integer, default: 0
  end
end
