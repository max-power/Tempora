require_relative 'timeperiod'
require_relative 'initialization'
require_relative 'month'
require_relative 'week'

class Quarter
  include TimePeriod
  extend Initialization

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
    
  def months
    Month.from(start_date)..Month.from(end_date)
  end
  
  def weeks
    Week.from(start_date)..Week.from(end_date)
  end
  
  private
  
  def self.initialization_parameter(date)
    quarter = ((date.month - 1) / 3) + 1
    [date.year, quarter]
  end
end
