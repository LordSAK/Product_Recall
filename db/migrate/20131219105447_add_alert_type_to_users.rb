class AddAlertTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :alert_type, :string
  end
end
