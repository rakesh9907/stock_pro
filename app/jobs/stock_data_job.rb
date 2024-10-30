class StockDataJob < ApplicationJob
  queue_as :default

  def perform(delivery_params, price_params)
    Delivery.create(delivery_params)
    Price.create(price_params)
  end
end

# t.references :stock, null: false, foreign_key: true
# t.decimal :quantity
# t.decimal :percentage
# t.decimal :volume
# t.time :delivery_time
# t.time :volume_time
# t.decimal :trades
# t.date :date


# {
#   "data": [
#     {
#       "close": 4308.7,
#       "date": "2024-09-27",
#       "delivery_perc": 54.1,
#       "delivery_qty": 1629655,
#       "high": 4378,
#       "low": 4300.05,
#       "open": 4335,
#       "traded_qty": 3012477,
#       "trades": 231071,
#       "vwap": 4327.38,
#       "week_52_high_price": 4592.25,
#       "week_52_low_price": 3311
#     }
#   ]
# }