class FetchDataJob < ApplicationJob
  queue_as :default

  def perform
    # service = ExternalApiService.new
    # data = service.get_data('/endpoint')
    # Process data (e.g., save to database)
  end
end