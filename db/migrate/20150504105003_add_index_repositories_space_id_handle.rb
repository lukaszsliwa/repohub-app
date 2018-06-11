class AddIndexRepositoriesSpaceIdHandle < ActiveRecord::Migration
  def change
    add_index :repositories, [:space_id, :handle], unique: true
  end
end
