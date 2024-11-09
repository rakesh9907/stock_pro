class StockDataJob < ApplicationJob
  queue_as :default

  def perform(delivery_params, price_params)
    # delivery = Delivery.create(delivery_params)
    Delivery.build(delivery_params)
    # Rails.logger.error(">>>>>>>>>>>>>>>>", delivery.save)

    # price = Price.create(price_params)
    # Rails.logger.error("????????????????", price.save)
  end
end
