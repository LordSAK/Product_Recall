class AddManufacturerAndProductsAndHazardsToRecalls < ActiveRecord::Migration
  def change
    add_column :recalls, :Manufacturer, :string
    add_column :recalls, :Products, :string
    add_column :recalls, :Hazards, :string
  end
end
