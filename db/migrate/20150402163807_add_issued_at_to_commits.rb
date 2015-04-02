class AddIssuedAtToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :issued_at, :datetime
  end
end
