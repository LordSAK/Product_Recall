class AddCellNoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :cell_no, :string 
  end
end
