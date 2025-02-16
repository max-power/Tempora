require_relative 'timeperiod'
require_relative 'tempora/initialization'

module Tempora
  class Week < TimePeriod
    extend Initialization
    
    def initialize(year, week)
      @year   = Integer(year)
      @number = Integer(week)
    
      @start_date = Date.commercial(@year, @number, 1)
      @end_date   = start_date + 6
    end
    
    def id(seperator="-")
      "#{year}#{seperator}W#{format('%02d', number)}"
    end
  
    def to_s
      "Week #{number}, #{year}"
    end
  
    def next
      self.class.from(start_date + 7)
    end

    def prev
      self.class.from(start_date - 7)
    end
  
    alias_method :succ, :next
    alias_method :pred, :prev
    
    private
  
    def self.initialization_parameter(date)
      [date.cwyear, date.cweek]
    end
  end
end