class AddIsActiveToSalesPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :sales_people, :is_active, :boolean, default: true
  end
end
