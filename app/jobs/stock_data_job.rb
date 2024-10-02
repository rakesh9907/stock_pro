class StockDataJob < ApplicationJob
  queue_as :default

  def perform(symbol, date)
    stock = Stock.find_by(symbol: symbol)
    return unless stock
    get_response = DeliveryApiService.new.deliver_data(symbol, date)
    data = get_response['data']
    Delivery.create(
      stock_id: stock.id,
      quantity: data["delivery_qty"],
      percentage: data["delivery_perc"],
      volume: data['traded_qty'],
      delivery_time: data['delivery_time'],
      volume_time: data['volume_time'],
      date: data['date']
    )

    Price.create(
      stock_id: stock.id,
      open: data['open'],
      close: data['close'],
      high: data['high'],
      low: data['low'],
      date: data['date'],
      vwap: data['vwap'],
      fifty_two_week_high: data['week_52_high_price'],
      fifty_two_week_low: data['week_52_low_price']
    )
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