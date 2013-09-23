class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :supplier
      t.integer :user_id

      t.timestamps
    end
    add_index :suppliers, [:user_id, :created_at]
  end
end
