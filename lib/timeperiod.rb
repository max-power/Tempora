require 'date'
require_relative 'tempora/has_days'
require_relative 'tempora/has_time'

module Tempora
  class TimePeriod
    include Comparable
    include HasDays
    include HasTime
  
    attr_reader :start_date, :end_date
  
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date   = end_date
    end

    def range
      start_date..end_date
    end

    def duration
      (end_date - start_date).to_i + 1
    end
    
    def future?
      start_date.future?
    end
    
    def past?
      end_date.past?
    end
    
    def contains?(date)
      range.cover?(date)
    end

    def overlaps?(other)
      range.overlap?(other.range)
    end

    def intersection(other)
      return nil unless overlaps?(other)

      new_start = [start_date, other.start_date].max
      new_end   = [end_date, other.end_date].min

      TimePeriod.new(new_start, new_end)
    end
  
    def shift(days)
      TimePeriod.new(@start_date + days, @end_date + days)
    end
  
    def <=>(other)
      start_date <=> other.start_date
    end
    
    def hash
      [self.class, id || range].hash
    end
    
    alias_method :begin,     :start_date
    alias_method :first_day, :start_date
    alias_method :end,       :end_date
    alias_method :last_day,  :end_date
    alias_method :length,    :duration
    alias_method :include?   :contains?
  end
end