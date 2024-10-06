class AddTradesTosectorDeliveries < ActiveRecord::Migration[7.2]
  def change
    add_column :sector_deliveries, :trades, :decimal
  end
end
