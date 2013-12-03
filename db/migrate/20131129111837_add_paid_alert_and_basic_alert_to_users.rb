class AddPaidAlertAndBasicAlertToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paid_Alert, :integer, default: 40
    add_column :users, :basic_Alert, :integer,default: 10
  end
end
