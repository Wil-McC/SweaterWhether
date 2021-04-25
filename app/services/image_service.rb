class ImageService
  def self.image_search(location)
    res = image_connection.get('/v1/search') do |req|
      req.params['query'] = location + ' skyline'
      req.params['per_page'] = 1
      req.params['orientation'] = 'square'
    end

    data = JSON.parse(res.body, symbolize_names: true)

    image_builder(data)
  end

  def self.image_connection
    image_connection ||= Faraday.new({
      url: ENV['IMAGE_URL'],
      headers: { 'Authorization': ENV['IMAGE_KEY'] }
    })
  end

  def self.image_builder(data)
    Image.new(data)
  end
end
