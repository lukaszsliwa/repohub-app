class RemoveTypeFromRepositories < ActiveRecord::Migration
  def change
    remove_column :repositories, :type, :string
  end
end
