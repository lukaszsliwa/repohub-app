class RemoveIndexRepositoriesHandle < ActiveRecord::Migration
  def change
    remove_index :repositories, :handle
  end
end
