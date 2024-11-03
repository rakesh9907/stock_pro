class StockDataJob < ApplicationJob
  queue_as :default

  def perform(delivery_params, price_params)
    delivery = Delivery.new(delivery_params)
    if(!delivery.save){
      Rails.logger.error(">>>>>>>>>>>>>>>>", delivery.save)
    }

    price = Price.create(price_params)
    if(!price.save){
      Rails.logger.error("????????????????", price.save)
    }
  end
end
