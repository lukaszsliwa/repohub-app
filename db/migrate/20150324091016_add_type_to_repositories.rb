class AddTypeToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :type, :string  
    add_index :repositories, [:type, :id], unique: true
  end
end
