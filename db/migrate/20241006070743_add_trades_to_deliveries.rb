class AddTradesToDeliveries < ActiveRecord::Migration[7.2]
  def change
    add_column :deliveries, :trades, :decimal
  end
end
