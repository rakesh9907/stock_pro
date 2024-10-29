class NseDataJob < ApplicationJob
  queue_as :default

  def perform(symbol, date)
    begin
      data = ExternalApiService.new.final_data(symbol, date)
      Rails.logger.info "Successfully fetched data: #{data.inspect}"
    rescue => e
      Rails.logger.error "Error in NseDataJob: #{e.message}"
    end
  end
end
