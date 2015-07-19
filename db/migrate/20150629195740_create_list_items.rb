class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.text :label

      t.timestamps
    end
  end
end
