class WeeklyDataJob < ApplicationJob
  queue_as :default

  def perform(symbol, state_date, end_date)
    stock = Stock.find_by(symbol: symbol)
    return unless stock

    deliveries = stock.deliveries.where(date: start_date..end_date)
    total_quantity = deliveries.sum(:quantity)
    total_volume = deliveries.sum(:volume)
    total_trades = deliveries.sum(:trades)
    perc = (total_quantity * 100) / total_volume

    
    weekly_deliveries = stock.weekly_deliveries.order(date: :desc).limit(5)
    total_weekly_deliver = weekly_deliveries.sum(:quantity)
    total_weekly_volume = weekly_deliveries.sum(:volume)
    total_weekly_trades = weekly_deliveries.sum(:total_trades)

    delivery_time = total_quantity / (total_weekly_deliver / 5)
    volume_time = total_volume / (total_weekly_volume / 5 )

    WeeklyDelivery.create!(
      stock: stock,
      start_date: start_date,
      end_date: end_date,
      delivery: total_quantity,
      percentage: perc,
      volume: total_volume,
      delivery_time: delivery_time,
      volume_time: volume_time,
      total_trades: total_trades
    )
  end
end