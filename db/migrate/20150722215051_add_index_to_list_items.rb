class AddIndexToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :index, :int
  end
end
