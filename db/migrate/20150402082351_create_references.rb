class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :type
      t.integer :repository_id
      t.string :name

      t.timestamps null: false
    end
    add_index :references, :type
    add_index :references, [:type, :repository_id]
  end
end
