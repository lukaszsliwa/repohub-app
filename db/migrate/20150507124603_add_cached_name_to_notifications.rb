class AddCachedNameToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :cached_name, :string
  end
end
