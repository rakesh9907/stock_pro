class DeliveryApiService < ExternalApiService
  def initialize
    super
  end

  def deliver_data(symbol, start_date, end_date)
    puts symbol, start_date, end_date
    url = "/stock/#{symbol}/delivery?start_date=#{start_date}&end_date=#{end_date}"
    get_data(url)
  end
end



