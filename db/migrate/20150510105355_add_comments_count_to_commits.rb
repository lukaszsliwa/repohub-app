class AddCommentsCountToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :comments_count, :integer, default: 0
  end
end
