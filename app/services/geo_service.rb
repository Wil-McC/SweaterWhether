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

  def self.coordinate_connection
    coordinate_connection ||= Faraday.new({
      url: ENV['COORD_URL']
    })
  end
end