class ImageFacade
  def self.skyline(loc)
    result = ImageService.image_search(loc)
    ImageSerializer.new(result)
  end
end
