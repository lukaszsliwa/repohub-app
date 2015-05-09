class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :repository_id
      t.integer :commit_id
      t.string :sha
      t.string :path
      t.integer :position
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :comments, :commit_id
  end
end
