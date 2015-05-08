class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.integer :user_id
      t.integer :notification_id

      t.timestamps null: false
    end
    add_index :user_notifications, [:user_id, :notification_id], unique: true
  end
end
