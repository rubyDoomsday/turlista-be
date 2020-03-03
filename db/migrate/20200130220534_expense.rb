# frozen_string_literal: true

class Expense < ActiveRecord::Migration[5.2]
  def up
    create_table :expenses, id: :uuid do |t|
      t.column :amount, :float
      t.column :event_id, :uuid, null: true
      t.column :description, :string, null: true
      t.column :trip_id, :uuid
      t.column :covered_by_id, :uuid
      t.timestamps
    end
  end

  def down
    drop_table :expenses
  end
end
