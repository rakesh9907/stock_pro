class DeliveriesController < ApplicationController

  def fetch_delivery
    stocks = Stock.all
    sectors = Sector.all
    industries = Industry.all
    date = params['date']
    
    stocks.each do |stock|
      StockDataJob.perform_now(stock.symbol, date)
      WeeklyDataJob.perform_now(stock.symbol, data)
    end
    
    industries.each do |industry|
      IndustryDataJob.perform_now(industry.id, date)
    end
    
    sectors.each do |sector|
      SectorDataJob.perform_now(sector.id, date)
    end
    
    render json: {message: "Delivery Updating"}
  end

  def weekly_delivery
    start_date = params['start_date']
    end_date = params['end_date']

    stocks = Stock.all
    stocks.each do |stock|
      WeeklyDataJob.perform_now(stock.symbol, start_date, end_date)
    end
    render json: {message: "Weekly delivery Updating"}
  end

  def alert
    stock_id,
    prices_id,
  end

end


# 1 filter stocks which have 1.5 times delivery
# 2 get prices_id of those stocks and that date
# 3 save this in alert tables
# 4 default status false when price go below and up then status is true
# 5 check the price is go above and below with in 5 days then status is true 
# 6 Other wise it will delete past alert data