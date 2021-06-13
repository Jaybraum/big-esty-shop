require 'rails_helper'

RSpec.describe HolidayService do
  it 'returns public holiday data' do
    mock_response = {
      :date=>"2021-07-05",
      :localName=>"Independence Day",
      :name=>"Independence Day",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>nil,
      :launchYear=>nil,
      :types=>["Public"]
    }
    allow(HolidayService).to receive(:public_holiday).and_return(mock_response)
    json = HolidayService.public_holiday

    expect(json).to be_a(Hash)
    expect(json).to have_key(:date)
    expect(json).to have_key(:name)
  end
end
