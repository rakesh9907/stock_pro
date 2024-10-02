class DeliveriesController < ApplicationController

  def fetch_delivery
    stocks = Stock.all
    sectors = Sector.all
    industries = Industry.all
    date = params['date']
    
    stocks.each do |stock|
      StockDataJob.perform_now(stock.symbol, date)
    end
    
    industries.each do |industry|
      IndustryDataJob.perform_now(industry.id, date)
    end
    
    sectors.each do |sector|
      SectorDataJob.perform_now(sector.id, date)
    end
    
    render json: {message: "Delivery Updating"}
  end
end