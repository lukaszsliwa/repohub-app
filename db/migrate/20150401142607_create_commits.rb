class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.integer :user_id
      t.integer :repository_id
      t.string :message
      t.string :sha
      t.string :branch
      t.string :author
      t.string :email

      t.timestamps null: false
    end

    add_index :commits, :repository_id
  end
end
