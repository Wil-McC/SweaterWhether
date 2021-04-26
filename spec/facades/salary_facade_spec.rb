require 'rails_helper'

RSpec.describe 'the salary facade' do
  it 'returns serialized payload' do
    payload = SalaryFacade.salary_forecast('denver')

    expect(payload).to be_an(OpenStruct)
    expect(payload.respond_to?('id')).to eq(true)
    expect(payload.respond_to?('destination')).to eq(true)
    expect(payload.respond_to?('forecast')).to eq(true)
    expect(payload.respond_to?('salaries')).to eq(true)
  end
end
