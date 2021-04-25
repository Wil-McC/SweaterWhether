require 'rails_helper'

RSpec.describe 'the image service' do
  it 'returns image data payload as a PORO' do
    VCR.use_cassette('image_search_happy') do
      out = ImageService.image_search('denver,co')

      expect(out).to be_an(Image)
      expect(out.respond_to?('id')).to eq(true)
      expect(out.respond_to?('photographer')).to eq(true)
      expect(out.respond_to?('photographer_url')).to eq(true)
      expect(out.respond_to?('credit')).to eq(true)
      expect(out.respond_to?('src')).to eq(true)
      expect(out.id).to eq(nil)
      expect(out.photographer).to eq("Pixabay")
      expect(out.photographer_url).to eq("https://www.pexels.com/@pixabay")
      expect(out.src).to eq("https://images.pexels.com/photos/290275/pexels-photo-290275.jpeg")
      expect(out.url).to eq("https://www.pexels.com/photo/architecture-blue-sky-buildings-business-290275/")
      expect(out.credit).to eq("All image credit goes to Pexels.com and the photographer. This is an educational project only.")
    end
  end
end
