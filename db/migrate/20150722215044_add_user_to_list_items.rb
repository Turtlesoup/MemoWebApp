class AddUserToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :user, :int
  end
end
