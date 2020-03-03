# frozen_string_literal: true

class Item < ActiveRecord::Migration[5.2]
  def up
    create_table :items, id: :uuid do |t|
      t.column :name, :string, limit: 300
      t.column :status, :string, limit: 300
      t.column :shopping_list_id, :uuid
      t.timestamps
    end
  end

  def down
    drop_table :items
  end
end
