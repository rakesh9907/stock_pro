class DeliveriesController < ApplicationController

  def get_delivery
    final_delivery = params['data'].map do |delivery_data|
      delivery_params(delivery_data)
    end

    final_price = params['data'].map do |price_data|
      price_params(price_data)
    end
    
    Delivery.insert_all(final_delivery)
    Price.insert_all(final_price)
    render json: { message: 'Delivery are updating'}
  end

  def fetch_delivery
    sectors = Sector.all
    industries = Industry.all
    
    industries.each do |industry|
      IndustryDataJob.perform_later(industry.id, date)
    end
    
    sectors.each do |sector|
      SectorDataJob.perform_later(sector.id, date)
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

  # def delivery_params
  #   params.permit(
  #     :stock_id,
  #     :quantity,
  #     :percentage,
  #     :volume,
  #     :delivery_time,
  #     :volume_time,
  #     :date,
  #     :trades
  #   )
  # end

  def delivery_params(data)
    data.permit(
      :stock_id,
      :quantity,
      :percentage,
      :volume,
      :delivery_time,
      :volume_time,
      :date,
      :trades)
  end

  def price_params(data)
    data.permit(
      :stock_id,
      :open,
      :close,
      :high,
      :low,
      :date,
      :fifty_two_week_high,
      :fifty_two_week_low,
      :vwap
    )
  end

  def fetch_deliveries(params, model_class, association_name)
    date = params['date'] || Date.today.strftime("%d-%m-%y")
    model_class.joins(association_name) 
                .where("#{association_name.to_s.singularize}.delivery_time > ?", 1.5)
                .where(association_name => { date: date })
                .distinct
  end
end
