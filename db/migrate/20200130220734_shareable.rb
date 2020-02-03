class Shareable < ActiveRecord::Migration[5.2]
  def up
    create_table :shareables, id: :uuid do |t|
      t.column :what, :string, limit: 300
      t.column :trip_id, :integer
      t.column :user_id, :integer
      t.timestamps
    end
  end

  def down
    drop_table :shareables
  end
end
