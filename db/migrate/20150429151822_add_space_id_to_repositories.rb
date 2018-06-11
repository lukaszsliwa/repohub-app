class AddSpaceIdToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :space_id, :integer
    add_index :repositories, :space_id
  end
end
