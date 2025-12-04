class RemoveItemsSoldFromSalesRecords < ActiveRecord::Migration[8.1]
  def change
    remove_column :sales_records, :items_sold, :integer
  end
end