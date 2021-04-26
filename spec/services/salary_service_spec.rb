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
        job[:min].class   == String
        job[:min][0]      == '$'
        job[:max].class   == String
        job[:max][0]      == '$'
      end
    ).to eq(true)
  end
end
