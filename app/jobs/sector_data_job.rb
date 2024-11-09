class SectorDataJob < ApplicationJob
  queue_as :default

  def perform(id, date)
    sector = Sector.find(id)
    industries = sector.industries
    total_delivery = 0
    total_volume = 0
    delivery_time = 0
    volume_time = 0
    
    industries.each do |industry|
      delivery = industry.industry_deliveries.order(date: :desc).first
      if delivery
        total_delivery = total_delivery + delivery.quantity
        total_volume = total_volume + delivery.volume
      end
    end
    per = (total_delivery * 100) / total_volume

    sector_deliveries = sector.sector_deliveries.order(date: :desc).limit(5)

    total_sector_deliver = sector_deliveries.sum(:quantity)
    total_sector_volume = sector_deliveries.sum(:volume)

    delivery_time = total_delivery / (total_sector_deliver / 5)
    volume_time = total_volume / (total_sector_volume / 5 )

    SectorDelivery.create(
      sector_id: sector.id,
      quantity: total_delivery,
      percentage: per,
      volume: total_volume,
      date: date,
      delivery_time: delivery_time,
      volume_time: volume_time
    )
  end
end