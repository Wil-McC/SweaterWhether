class Image
  attr_reader :id,
              :url,
              :photographer,
              :photographer_url,
              :src,
              :credit

  def initialize(data)
    @id = nil
    @url = data[:photos][0][:url]
    @photographer = data[:photos][0][:photographer]
    @photographer_url = data[:photos][0][:photographer_url]
    @src = data[:photos][0][:src][:original]
    @credit = 'All image credit goes to Pexels.com and the photographer. This is an educational project only.'
  end
end
