class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :vendor
      t.integer :user_id

      t.timestamps
    end
    add_index :vendors, [:user_id, :created_at]
  end
end
