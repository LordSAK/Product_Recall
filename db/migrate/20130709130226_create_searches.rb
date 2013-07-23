class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :searches
      t.integer :user_id

      t.timestamps
    end
    add_index :searches, [:user_id, :created_at]
  end
end
