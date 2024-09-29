class ExternalApiService
  # BASE_URL = 'https://www.nseindia.com'
  BASE_URL = 'https://verbose-space-potato-v6pgw5p56rxvfpw4v-5001.app.github.dev'

  def initialize
    @connection = Faraday.new(url: BASE_URL) do |conn|
      conn.request :json # Converts request data to JSON
      conn.response :json # Parses JSON responses
      conn.adapter Faraday.default_adapter # Use the default adapter
    end
  end

  def post_data(endpoint, body={})
    response = @connection.post(endpoint, params)
    response.body
  end

  def get_data(endpoint, params={})
    response = @connection.get(endpoint)
    case response.status
    when 200
      response.body
    when 302
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