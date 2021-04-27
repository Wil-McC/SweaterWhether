class GeoService
  def self.get_coords(loc)
    res = coordinate_connection.get("/geocoding/v1/address") do |req|
      req.params['key'] = ENV['COORD_KEY']
      req.params['location'] = loc
    end
    data = JSON.parse(res.body, symbolize_names: true)
    # pull lat and long hash out of payload
    data[:results][0][:locations][0][:latLng]
  end

  def self.travel_time(orig, dest)
    url = "http://www.mapquestapi.com/directions/v2/routematrix"
    body = { locations: [orig, dest] }.to_json

    res = Faraday.post(url) do |req|
      req.params['key'] = ENV['COORD_KEY']
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
      req.body = body
    end

    data = JSON.parse(res.body, symbolize_names: true)

    hours = data[:time][1] / 3600.0
    dest_coords = data[:locations][1][:displayLatLng]
    dest_coords[:hrs] = hours
    dest_coords
  end


  def self.coordinate_connection
    coordinate_connection ||= Faraday.new({
      url: ENV['COORD_URL']
    })
  end
end
