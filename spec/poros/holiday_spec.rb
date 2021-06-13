require 'rails_helper'

RSpec.describe Holiday do
  it 'has data' do
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
    #this can use VCR, for now we can comment out the mock data to check on the API
    allow(HolidayService).to receive(:public_holiday).and_return(mock_response)
    public_holiday = Holiday.new
    expect(public_holiday).to be_an_instance_of(Holiday)
  end

  it 'upcoming_holidays' do
    public_holiday = Holiday.new

    expect(public_holiday.upcoming_holidays).to be_an(Array)

  end
end
