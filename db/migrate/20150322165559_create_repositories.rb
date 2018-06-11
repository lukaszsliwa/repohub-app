class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :handle
      t.string :description
      t.integer :created_by_id

      t.timestamps null: false
    end
    add_index :repositories, :handle, unique: true
  end
end
