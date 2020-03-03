# frozen_string_literal: true

class ShoppingList < ActiveRecord::Migration[5.2]
  def up
    create_table :shopping_lists, id: :uuid do |t|
      t.column :kind, :string, limit: 300
      t.column :total, :integer, null: true
      t.column :trip_id, :uuid
      t.column :volunteer_id, :uuid, null: true
      t.timestamps
    end
  end

  def down
    drop_table :shopping_lists
  end
end
