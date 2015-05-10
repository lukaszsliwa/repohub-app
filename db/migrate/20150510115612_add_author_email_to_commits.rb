class AddAuthorEmailToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :author_email, :string
  end
end
