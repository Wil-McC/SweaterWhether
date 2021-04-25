require 'rails_helper'

RSpec.describe 'the image facade' do
  it 'returns serialized payload result' do
    VCR.use_cassette('image_search_happy') do
      res = ImageFacade.skyline('denver,co')
      
      expect(res).to be_an(ImageSerializer)
    end
  end
end
