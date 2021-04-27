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
      expect(out.photographer).to eq("Colin Lloyd")
      expect(out.photographer_url).to eq("https://www.pexels.com/@colin-lloyd-2120291")
      expect(out.src).to eq("https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg")
      expect(out.url).to eq("https://www.pexels.com/photo/red-and-white-concrete-building-during-night-time-3751010/")
      expect(out.credit).to eq("All image credit goes to Pexels.com and the photographer. This is an educational project only.")
    end
  end
end
