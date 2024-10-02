class DeliveryApiService < ExternalApiService
  def initialize
    super
  end

  def deliver_data(symbol, date)
    url = "/stock/#{symbol}/delivery?date=#{date}"
    get_data(url)
  end
end



