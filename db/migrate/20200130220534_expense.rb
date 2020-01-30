class Expense < ActiveRecord::Migration[5.2]
  def up
    create_table :expenses do |t|
      t.column :amount, :float
      t.column :event_id, :integer, null: true
      t.column :trip_id, :integer
      t.column :covered_by_id, :integer
      t.timestamps
    end
  end

  def down
    drop_table :expenses
  end
end
