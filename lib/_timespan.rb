require 'date'

class TimeSpan
  include Comparable

  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = TimeSpan.from_date_like(start_date)
    @end_date = TimeSpan.from_date_like(end_date)

    raise ArgumentError, "start_date must be before end_date" if @start_date > @end_date
  end

  def self.from_date_like(date_like)
    if date_like.respond_to?(:year) && date_like.respond_to?(:month) && date_like.respond_to?(:day)
      Date.new(date_like.year, date_like.month, date_like.day)
    else
      raise ArgumentError, "Invalid date-like object: #{date_like.inspect}"
    end
  end

  def range
    @start_date..@end_date
  end

  def duration
    (@end_date - @start_date).to_i + 1
  end

  def overlaps?(other)
    @start_date <= other.end_date && @end_date >= other.start_date
  end

  def contains?(date)
    range.cover?(TimeSpan.from_date_like(date))
  end

  def shift(days)
    TimeSpan.new(@start_date + days, @end_date + days)
  end

  def intersection(other)
    return nil unless overlaps?(other)

    new_start = [@start_date, other.start_date].max
    new_end = [@end_date, other.end_date].min

    TimeSpan.new(new_start, new_end)
  end

  def <=>(other)
    start_date <=> other.start_date
  end

  def to_s
    "#{@start_date} to #{@end_date} (#{duration} days)"
  end
end
# 🔹 TimeSpan Class (For Any Date Range)
#
# This will handle custom periods, like fiscal years, school semesters, or project timelines.
#
# 🔹 How TimeSpan Works
#
# ✅ Define Any Custom Date Range
# fiscal_year = TimeSpan.new(Date.new(2024, 4, 1), Date.new(2025, 3, 31))
# puts fiscal_year.to_s
# # => "2024-04-01 to 2025-03-31 (365 days)"
# ✅ Check Overlaps
# q2 = TimeSpan.new(Date.new(2024, 4, 1), Date.new(2024, 6, 30))
# q3 = TimeSpan.new(Date.new(2024, 7, 1), Date.new(2024, 9, 30))
# puts q2.overlaps?(q3)  # => false
# ✅ Check If a Date Falls Within the Range
# semester = TimeSpan.new(Date.new(2024, 8, 1), Date.new(2024, 12, 15))
# puts semester.contains?(Date.new(2024, 9, 10))  # => true
# puts semester.contains?(Date.new(2025, 1, 1))   # => false
# ✅ Shift Date Ranges
# event = TimeSpan.new(Date.new(2024, 6, 10), Date.new(2024, 6, 15))
# puts event.shift(7).to_s
# # => "2024-06-17 to 2024-06-22 (6 days)"
# 
# 🔹 Why TimeSpan is Useful
#
# ✅ Handles custom time ranges (fiscal years, semesters, event durations)
# ✅ Works alongside Week, Month, Quarter, and Year
# ✅ Supports overlapping checks and shifts
#
# 🔹 How intersection Works
#
# ✅ Two Overlapping Periods
# t1 = TimeSpan.new(Date.new(2024, 3, 1), Date.new(2024, 3, 20))
# t2 = TimeSpan.new(Date.new(2024, 3, 10), Date.new(2024, 3, 25))
#
# overlap = t1.intersection(t2)
# puts overlap.to_s
# # => "2024-03-10 to 2024-03-20 (11 days)"
# ✅ No Overlap Returns nil
# t3 = TimeSpan.new(Date.new(2024, 4, 1), Date.new(2024, 4, 10))
# puts t1.intersection(t3)
# # => nil
# 🔹 Why intersection is Useful
#
# ✅ Find common time slots (e.g., two employees' available time)
# ✅ Determine overlapping project phases
# ✅ Works with any time period comparisons
