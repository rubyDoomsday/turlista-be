class Item < ActiveRecord::Migration[5.2]
  def up
    create_table :items do |t|
      t.column :name, :string, limit: 300
      t.column :status, :string, limit: 300
      t.column :shopping_list_id, :integer
      t.timestamps
    end
  end

  def down
    drop_table :items
  end
end
