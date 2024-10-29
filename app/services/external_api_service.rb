class ExternalApiService
  include HTTParty

  BASE_URL = 'https://www.nseindia.com'

  QUOTE_HEADERS = {
    "Host" => "www.nseindia.com",
    "Connection" => "keep-alive",
    "Accept" => "*/*",
    "X-Requested-With" => "XMLHttpRequest",
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36",
    "Referer" => "https://www.nseindia.com/report-detail/eq_security"
  }

  MAX_RETRIES = 3

  def initialize
    Rails.logger.error("fetching cookies--------------")
    response = HTTParty.get(BASE_URL, headers: QUOTE_HEADERS, timeout: 120)
    Rails.logger.error("Failed to fetch delivery data")
    @cookies = response.headers['set-cookie'].to_s.split(',').map(&:strip).join('; ')
  end

  def fetch_delivery(symbol, start_date, end_date)
    target_url = "https://www.nseindia.com/api/historical/securityArchives?from=#{start_date}&to=#{end_date}&symbol=#{symbol}&dataType=priceVolumeDeliverable&series=ALL"
    
    retries = 0

    begin
      response = HTTParty.get(target_url, headers: QUOTE_HEADERS.merge!({'Cookie' => @cookies}), timeout: 120)
      
      if response.success?
        JSON.parse(response.body)
      else
        Rails.logger.error("Failed to fetch delivery data: #{response.code} - #{response.message}")
        nil
      end
    rescue HTTParty::Error => e
      Rails.logger.error("HTTParty Error: #{e.message}")
      retry_request(symbol, start_date, end_date, retries)
    rescue StandardError => e
      Rails.logger.error("Error fetching delivery: #{e.message}")
      nil
    end
  end

  def retry_request(symbol, start_date, end_date, retries)
    if retries < MAX_RETRIES
      retries += 1
      sleep(2 ** retries) # Exponential backoff
      fetch_delivery(symbol, start_date, end_date)
    else
      Rails.logger.error("Max retries reached for #{symbol}.")
      nil
    end
  end

  def final_data(symbol, date)
    start_date = '15-10-2024'
    end_date = '25-10-2024'
    data = fetch_delivery(symbol, start_date, end_date)

    return "No data available" if data.nil? || data["data"].empty?

    data = data["data"].reverse
    current_data = data[0]
    rest_data = data[1..-1]
    final_data = rest_data.first(5)

    if final_data.length < 5
      return "Data should be greater than 5"
    end

    # Extract current data points
    high_price = current_data['CH_TRADE_HIGH_PRICE']
    low_price = current_data['CH_TRADE_LOW_PRICE']
    open_price = current_data['CH_OPENING_PRICE']
    close_price = current_data['CH_CLOSING_PRICE']
    trades = current_data['CH_TOTAL_TRADES']
    traded_qty = current_data['CH_TOT_TRADED_QTY']
    delivery_perc = current_data['COP_DELIV_PERC']
    delivery_qty = current_data['COP_DELIV_QTY']
    vwap = current_data['VWAP']
    timestamp = current_data['CH_TIMESTAMP']
    high_price_52_week = current_data['CH_52WEEK_HIGH_PRICE']
    low_price_52_week = current_data['CH_52WEEK_LOW_PRICE']

    # Calculate totals
    total_delivery_qty = final_data.sum { |d| d['COP_DELIV_QTY'] } / 5.0
    total_volume_qty = final_data.sum { |d| d['CH_TOT_TRADED_QTY'] } / 5.0

    # Calculate delivery and volume time
    delivery_time = current_data['COP_DELIV_QTY'].to_f / total_delivery_qty
    volume_time = current_data['CH_TOT_TRADED_QTY'].to_f / total_volume_qty

    {
      open: open_price,
      close: close_price,
      high: high_price,
      low: low_price,
      trades: trades,
      traded_qty: traded_qty,
      delivery_perc: delivery_perc,
      delivery_qty: delivery_qty,
      vwap: vwap,
      date: timestamp,
      week_52_high_price: high_price_52_week,
      week_52_low_price: low_price_52_week,
      delivery_time: delivery_time,
      volume_time: volume_time
    }
  end
end
