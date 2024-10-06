class AddTradesToindustryDeliveries < ActiveRecord::Migration[7.2]
  def change
    add_column :industry_deliveries, :trades, :decimal
  end
end
