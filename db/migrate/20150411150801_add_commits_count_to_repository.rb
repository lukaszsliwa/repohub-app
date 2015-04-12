class AddCommitsCountToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :commits_count, :integer, default: 0
  end
end
