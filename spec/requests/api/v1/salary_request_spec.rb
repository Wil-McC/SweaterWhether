require 'rails_helper'

RSpec.describe 'the salary request' do
  it 'returns payload with current weather and 7 title salaries' do
    get '/api/v1/salaries?destination=denver'

    expect(response).to be_successful
    forecast = JSON.parse(response.body, symbolize_names: true)
  end
end
