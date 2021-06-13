class Holiday
  attr_reader :holiday_name,
              :holiday_date
  def initialize
    holiday_data = HolidayService.public_holiday
    @holiday_name = holiday_data[:name]
    @holiday_date = holiday_data[:date]
  end
end
