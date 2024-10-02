class DeliveriesController < ApplicationController

  def fetch_delivery
    stocks = Stock.all
    sectors = Sector.all
    industries = Industry.all
    stocks.each do |stock|
      StockDataJob.perform_now(stock.symbol, "01-10-2024")
    end
    
    industries.each do |industry|
    end
    
    sectors.each do |sector|
    end
    
    render json: {message: "Delivery Updating"}
  end
end