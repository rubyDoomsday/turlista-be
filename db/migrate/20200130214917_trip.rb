class Trip < ActiveRecord::Migration[5.2]
  def up
    create_table :trips, id: :uuid do |t|
      t.column :title, :string, limit: 300
      t.column :start_date, :date
      t.column :end_date, :date
      t.column :owner_id, :uuid
      t.timestamps
    end
  end

  def down
    drop_table :trips
  end
end
