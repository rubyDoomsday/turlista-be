class Event < ActiveRecord::Migration[5.2]
  def up
    create_table :events, id: :uuid do |t|
      t.column :start_time, :datetime
      t.column :end_time, :datetime, null: true
      t.column :category, :string, limit: 300
      t.column :description, :string, limit: 300
      t.column :title, :string, limit: 300
      t.column :location, :string, null: true
      t.column :notes, :string, null: true
      t.column :trip_id, :uuid
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
