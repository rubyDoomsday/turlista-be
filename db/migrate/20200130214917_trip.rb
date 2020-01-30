class Trip < ActiveRecord::Migration[5.2]
  def up
    create_table :trips do |t|
      t.column :title, :string, limit: 300
      t.column :start_date, :timestamp
      t.column :end_date, :timestamp
      t.column :owner_id, :integer
      t.timestamps
    end
  end

  def down
    drop_table :trips
  end
end
