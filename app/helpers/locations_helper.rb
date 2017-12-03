module LocationsHelper
  # Parse the API data to store it in a Ruby array of hashes - each bus is a hash
  def fetch_buses_from_api(bus_api_url)
    raw_http = Net::HTTP.get_response(URI.parse(bus_api_url))
    bus_data = raw_http.body
    JSON.parse(bus_data)
  end

  # Return true if a bus is near to the user and false otherwise.

  def is_nearby?(user_lat, user_long, bus_lat, bus_long)
    # Max distance in degrees, approx 0.6 miles
    max_distance = 0.01
    difference_latitudes = user_lat - bus_lat.to_f
    difference_longitudes = user_long - bus_long.to_f
    distance = Math.sqrt(difference_latitudes**2 + difference_longitudes**2)
    distance <= max_distance
  end
end
