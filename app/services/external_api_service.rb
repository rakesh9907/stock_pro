class ExternalApiService
  BASE_URL = 'https://www.nseindia.com'

  def initialize

  end

  def post_data(endpoint, params)
    response = @connection.post(endpoint, params)
    response.body
  end

  def get_data(endpoint)
    response = @connection.get(endpoint)
  
    case response.status
    when 200
      response.body
    when 404
      raise "Resource not found"
    else
      raise "API error: #{response.status}"
    end
  rescue Faraday::ConnectionFailed => e
    # Handle connection errors
    Rails.logger.error "Connection failed: #{e.message}"
    nil
  end
end