class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :space_id
      t.integer :repository_id
      t.string  :resource_name
      t.integer :resource_id
      t.string :sha
      t.string :message
      t.string :annotation

      t.timestamps null: false
    end
    add_index :notifications, :user_id
    add_index :notifications, :space_id
    add_index :notifications, :repository_id
    add_index :notifications, [:space_id, :repository_id]
  end
end
