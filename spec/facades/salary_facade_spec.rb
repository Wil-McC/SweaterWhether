require 'rails_helper'

RSpec.describe 'the salary facade' do
  it 'returns serialized payload' do
    payload = SalaryFacade.salary_forecast('denver')

    expect(payload).to be_an(OpenStruct)
  end
end
