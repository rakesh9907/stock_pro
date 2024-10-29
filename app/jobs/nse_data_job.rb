class NseDataJob < ApplicationJob
  queue_as :default
  retry_on Net::ReadTimeout, wait: :exponentially_longer, attempts: 3

  def perform(symbol, date)
    data = ExternalApiService.new.final_data('TCS', "24-10-2024")
    Rails.logger.error "API request timed out #{data}"
  end
end