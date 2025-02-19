require_relative 'timeperiod'
require_relative 'tempora/initialization'
require_relative 'tempora/has_months'
require_relative 'tempora/has_weeks'

module Tempora
  class Quarter < TimePeriod
    extend Initialization
    include HasMonths
    include HasWeeks
    
    attr_reader :year, :number

    def initialize(year, quarter)
      @year   = Integer(year)
      @number = Integer(quarter).clamp(1,4)

      start_month = (quarter - 1) * 3 + 1
      @start_date = Date.new(year, start_month, 1)
      @end_date   = @start_date.next_month(3).prev_day
    end
  
    def id(seperator="-")
      "#{year}#{seperator}Q#{number}"
    end

    def to_s
      "Q#{number} #{year}"
    end
  
    def next
      self.class.from(start_date >> 3)
    end

    def prev
      self.class.from(start_date << 3)
    end
  
    alias_method :succ, :next
    alias_method :pred, :prev
  
    private
  
    def self.initialization_parameter(date)
      [date.year, quarter_from_date(date)]
    end
  
    def self.quarter_from_date(date)
      ((date.month - 1) / 3) + 1
    end
  end
end