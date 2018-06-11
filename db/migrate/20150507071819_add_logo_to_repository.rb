class AddLogoToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :logo, :string
  end
end
