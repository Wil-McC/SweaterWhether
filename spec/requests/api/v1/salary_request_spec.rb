require 'rails_helper'

RSpec.describe 'the salary request' do
  it 'returns payload with current weather and 7 title salaries' do
    get '/api/v1/salaries?destination=denver'

    expect(response).to be_successful
    res = JSON.parse(response.body, symbolize_names: true)

    expect(res).to be_a(Hash)
    expect(res.keys).to eq([:data])
    expect(res[:data].keys).to eq([:id, :type, :attributes])
    expect(res[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
    expect(res[:data][:attributes][:destination]).to be_a(String)
    expect(res[:data][:attributes][:destination]).to eq('denver')
    expect(res[:data][:attributes][:forecast]).to be_a(Hash)
    expect(res[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
    expect(res[:data][:attributes][:salaries]).to be_an(Array)
    expect(res[:data][:attributes][:salaries].first).to be_a(Hash)
    expect(res[:data][:attributes][:salaries].first.keys).to eq([:title, :min, :max])
    expect(res[:data][:attributes][:salaries].first[:title]).to be_a(String)
    expect(res[:data][:attributes][:salaries].first[:min]).to be_a(String)
    expect(res[:data][:attributes][:salaries].first[:max]).to be_a(String)
  end
end
