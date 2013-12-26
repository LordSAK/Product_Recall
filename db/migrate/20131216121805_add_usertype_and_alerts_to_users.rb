class AddUsertypeAndAlertsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :usertype, :string,default: 'Basic'
    add_column :users, :alerts, :integer
  end
end
