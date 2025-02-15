require_relative 'timeperiod'
require_relative 'tempora/initialization'
require_relative 'tempora/has_months'
require_relative 'tempora/has_weeks'

class Year < TimePeriod
  extend Initialization
  include HasWeeks
  include HasMonths
  
  def initialize(year)
    @year = Integer(year)
    
    @start_date = Date.new(@year, 1, 1)
    @end_date   = Date.new(@year, 12, 31)
  end
  
  def id
    year
  end

  def to_s
    year.to_s
  end
  
  def next
    self.class.new(year + 1)
  end
  
  def prev
    self.class.new(year - 1)
  end

  alias_method :succ, :next
  alias_method :pred, :prev
end