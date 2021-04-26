require 'rails_helper'

RSpec.describe 'the salary service' do
  it 'returns cleaned job salary data' do
    res = SalaryService.fetch_salaries('denver')

    expect(res).to be_an(Array)
    expect(res.length).to eq(7)
    expect(
      res.all? do |job|
        job.class         == Hash
        job.keys          == [:title, :min, :max]
        job[:title].class == String
        job[:min].class   == Float
        job[:max].class   == Float
      end
    ).to eq(true)
  end
end
