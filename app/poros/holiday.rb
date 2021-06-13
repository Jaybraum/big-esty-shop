class Holiday
  def initialize
    @holiday_data = HolidayService.public_holiday
  end

  def upcoming_holidays
    @holiday_data.take(3)
  end
end
