require 'rails_helper'

RSpec.describe 'the salary facade' do
  it 'returns ostruct object with desired attributes' do
    payload = SalaryFacade.salary_forecast('denver')

    expect(payload).to be_an(OpenStruct)
    expect(payload.respond_to?('id')).to eq(true)
    expect(payload.respond_to?('destination')).to eq(true)
    expect(payload.respond_to?('forecast')).to eq(true)
    expect(payload.respond_to?('salaries')).to eq(true)
    expect(payload.id).to eq(nil)
    expect(payload.destination).to be_a(String)
    expect(payload.destination).to eq('denver')
    expect(payload.forecast).to be_a(Hash)
    expect(payload.forecast.keys).to eq([:summary, :temperature])
    expect(payload.forecast[:summary]).to be_a(String)
    expect(payload.forecast[:temperature]).to be_a(String)
    expect(payload.forecast[:temperature][-1]).to eq("F")
    expect(payload.salaries).to be_an(Array)
    expect(
      payload.salaries.all? do |job|
        job.keys          == [:title, :min, :max]
        job[:title].class == String
        job[:min].class   == String
        job[:min][0]      == '$'
        job[:max].class   == String
        job[:max][0]      == '$'
      end
    ).to eq(true)
  end
  it "slim_weather class method" do
    des = 'denver'
    lat_lng = GeoService.get_coords(des)
    extended = ForecastService.get_five_day(lat_lng[:lat], lat_lng[:lng])

    slim = SalaryFacade.slim_weather(extended.current_weather)

    expect(slim).to be_a(Hash)
    expect(slim.keys).to eq([:summary, :temperature])
    expect(slim[:summary]).to be_a(String)
    expect(slim[:temperature]).to be_a(String)
    expect(slim[:temperature][-1]).to eq('F')
  end
end
