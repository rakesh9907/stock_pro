class AddQuantityToWeeklyDeliveries < ActiveRecord::Migration[7.2]
  def change
    add_column :weekly_deliveries, :quantity, :decimal
  end
end
