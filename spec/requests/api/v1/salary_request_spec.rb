require 'rails_helper'

RSpec.describe 'the salary request' do
  it 'returns payload with current weather and 7 title salaries' do
    get '/api/v1/salaries?destination=denver'

    expect(response).to be_successful
    res = JSON.parse(response.body, symbolize_names: true)

    expect(res).to be_a(Hash)
    expect(res.keys).to eq([:data])
    expect(res[:data].keys).to eq([:id, :type, :attributes])
  end
end
