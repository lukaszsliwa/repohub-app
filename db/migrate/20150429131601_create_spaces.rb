class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :handle

      t.timestamps null: false
    end
    add_index :spaces, :handle, unique: true
  end
end
