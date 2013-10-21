class AddUsertypeAndAlertToUsers < ActiveRecord::Migration
  def change
    add_column :users, :usertype, :string
    add_column :users, :alerts, :integer
  end
end
