class IndustryDataJob < ApplicationJob
  queue_as :default

  def perform(id, date)
    industry = Industry.find(id)
    stocks = industry.stocks
    total_delivery = 0
    total_volume = 0
    delivery_time = 0
    volume_time = 0
    
    stocks.each do |stock|
      delivery = stock.deliveries.order(date: :desc).first
      if delivery
        total_delivery = total_delivery + delivery.quantity
        total_volume = total_volume + delivery.volume
      end
    end
    per = (total_delivery * 100) / total_volume

    industry_deliveries = industry.industry_deliveries.order(date: :desc).limit(5)
    total_industry_deliver = industry_deliveries.sum(:quantity)
    total_industry_volume = industry_deliveries.sum(:volume)

    delivery_time = total_delivery / (total_industry_deliver / 5)
    volume_time = total_volume / (total_industry_volume / 5 )

    IndustryDelivery.create(
      industry_id: industry.id,
      quantity: total_delivery,
      percentage: per,
      volume: total_volume,
      date: date,
      delivery_time: delivery_time,
      volume_time: volume_time
    )
  end
end