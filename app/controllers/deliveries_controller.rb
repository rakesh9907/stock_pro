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

  # def delivery_stock
    date = params['date'] || Date.today.strftime("%d-%m-%y")
    # delivery_stock = Stock.joins(:deliveries)
    #                  .where('deliveries.delivery_time > ?', 1.5)
    #                  .where(deliveries: { date: date })
    #                    .distinct # it will return only return unique stock for those date

  #   render json: delivery_stock, each_serializer: StockSerializer
  # end

  def delivery_sector
    render json: fetch_deliveries(params, Sector, :sector_deliveries), each_serializer: SectorSerializer
  end

  def delivery_industry
    render json: fetch_deliveries(params, Industry, :industry_deliveries), each_serializer: IndustrySerializer
  end
  def delivery_stock
    render json: fetch_deliveries(params, Stock, :deliveries), each_serializer: StockSerializer
  end

  # 1 filter stocks which have 1.5 times delivery
  # 2 get prices_id of those stocks and that date
  # 3 save this in alert tables
  # 4 default status false when price go below and up then status is true
  # 5 check the price is go above and below with in 5 days then status is true 
  # 6 Other wise it will delete past alert data
  def alert
  end

  # Alert Table have with Name 
  # AlertItem Table have with stock_id, price, date, alert_id

  private

  def fetch_deliveries(params, model_class, association_name)
    date = params['date'] || Date.today.strftime("%d-%m-%y")
    model_class.joins(association_name) 
                .where("#{association_name.to_s.singularize}.delivery_time > ?", 1.5)
                .where(association_name => { date: date })
                .distinct
  end

end
