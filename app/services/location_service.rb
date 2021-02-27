class LocationService 
  
  def self.get_zip_codes(origin, radius)
    conn = zip_code_connection
    response = conn.get("zipcodes/#{origin}/#{radius}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private 

  def self.zip_code_connection
    Faraday.new(ENV['ZIPCODE_MICROSERVICE_BASE_URL'])
  end
end
