require 'date'

module TimePeriod
  include Comparable
  
  attr_reader :start_date, :end_date, :year, :number

  def range
    @start_date..@end_date
  end

  def duration
    (@end_date - @start_date).to_i + 1
  end
  
  def days
    range.to_a
  end

  def each_day(&block)
    range.each(&block)
  end

  def contains?(date)
    range.cover?(date)
  end

  def overlaps?(other)
    range.overlaps?(other.range)
  end

  def intersection(other)
    return nil unless overlaps?(other)

    new_start = [@start_date, other.start_date].max
    new_end = [@end_date, other.end_date].min

    self.class.new(new_start, new_end)
  end
  
  def <=>(other)
    @start_date <=> other.start_date
  end
  
  alias_method :begin, :start_date
  alias_method :end, :end_date
  alias_method :length, :duration
end

