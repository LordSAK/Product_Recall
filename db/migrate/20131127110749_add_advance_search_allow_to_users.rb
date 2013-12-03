class AddAdvanceSearchAllowToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Advance_Search_allow, :string
  end
end
