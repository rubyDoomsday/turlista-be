class ShoppingList < ActiveRecord::Migration[5.2]
  def up
    create_table :shopping_lists do |t|
      t.column :kind, :string, limit: 300
      t.column :total, :integer, null: true
      t.column :trip_id, :integer
      t.column :volunteer_id, :integer, null: true
      t.timestamps
    end
  end

  def down
    drop_table :shopping_lists
  end
end
