class WeeklyDataJob < ApplicationJob
  queue_as :default

  def perform(symbol, state_date, end_date)
    stock = Stock.find_by(symbol: symbol)
    
  end
end