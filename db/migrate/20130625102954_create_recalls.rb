class CreateRecalls < ActiveRecord::Migration
  def change
    create_table :recalls do |t|
      t.string :Category
      t.text :Title
      t.datetime :Time
      t.text :Summary
      t.text :Details

      t.timestamps
    end
  end
end
