class NseDataJob < ApplicationJob
  queue_as :default

  def perform(symbol, date)
    data = ExternalApiService.new.final_data('TCS', "24-10-2024")
    Rails.logger.error "API request timed out #{data}"
  end
end