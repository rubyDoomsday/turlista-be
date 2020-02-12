class User < ActiveRecord::Migration[5.2]
  def up
    create_table :users, id: :uuid do |t|
      t.column :first_name, :string, limit: 300
      t.column :last_name, :string, limit: 300
      t.column :email, :string, limit: 300
      t.column :trip_id, :uuid
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
