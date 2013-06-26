class CreateRecalls < ActiveRecord::Migration
  def change
    create_table :recalls do |t|
      t.string :Category
      t.string :Title
      t.datetime :Time
      t.string :Summary
      t.string :Details

      t.timestamps
    end
  end
end
