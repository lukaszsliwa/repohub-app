class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.integer :user_id
      t.string :name
      t.text :value

      t.timestamps null: false
    end
  end
end
