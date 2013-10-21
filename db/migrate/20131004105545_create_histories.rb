class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.datetime :TimeLogin
      t.datetime :TimeLogout
      t.integer :user_id

      t.timestamps
    end
    add_index :histories, [:user_id,:created_at]
  end
end
