class CreateUserRepositorySubscriptions < ActiveRecord::Migration
  def change
    create_table :user_repository_subscriptions do |t|
      t.integer :user_id
      t.integer :repository_id
      t.boolean :email

      t.timestamps null: false
    end
    add_index :user_repository_subscriptions, [:user_id, :repository_id], unique: true, name: 'user_id_repository_id_subs'
  end
end
