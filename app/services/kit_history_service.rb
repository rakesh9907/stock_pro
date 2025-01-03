class KitHistoryService
  include HTTParty

# +EuDzrV+7HtLI2fVLVTdnvq3hK9Hq6hyYOLeERu9LUoqSpP2kFML1ZZDlTKgs9m7Yj7xOoq56zQkVPuQK6wks2wa5tTTzbVYCgD6HYR3rBOQiTkif8qU7Q==
  BASE_URL = 'https://kite.zerodha.com/oms'
  def initialize(token)
    @headers = { "Authorization" => "enctoken #{token}" }
  end

  def historical_data(instrument_token, from_date, to_date, interval, continuous = false, oi = false)
    params = {
      "from" => from_date,
      "to" => to_date,
      "interval" => interval,
      "continuous" => continuous ? 1 : 0,
      "oi" => oi ? 1 : 0
    }
    response = self.class.get("#{BASE_URL}/instruments/historical/#{instrument_token}/#{interval}", query: params, headers: @headers)
    data = response['data']['candles'].map do |i|
      {
        "date" => DateTime.parse(i[0]),
        "open" => i[1],
        "high" => i[2],
        "low" => i[3],
        "close" => i[4],
        "volume" => i[5],
        # "oi" => i[6] if i.length == 7
      }
    end
    data
  end

end