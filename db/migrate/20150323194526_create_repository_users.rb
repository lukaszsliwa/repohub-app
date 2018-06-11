class CreateRepositoryUsers < ActiveRecord::Migration
  def change
    create_table :repository_users do |t|
      t.integer :repository_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :repository_users, [:repository_id, :user_id], unique: true
  end
end
