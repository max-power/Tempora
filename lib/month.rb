require_relative 'timeperiod'
require_relative 'initialization'
require_relative 'week'

class Month
  include TimePeriod
  extend Initialization

  def initialize(year, month)
    @year   = Integer(year)
    @number = Integer(month).clamp(1, 12)
    
    @start_date = Date.new(@year, @number,  1)
    @end_date   = Date.new(@year, @number, -1)
  end
  
  def id(seperator="-")
    "#{year}#{seperator}#{number.to_s.rjust(2, '0')}"
  end

  def to_s
    "#{month_name} #{year}"
  end

  def month_name
    Date::MONTHNAMES[number]
  end
  
  def month_abbr
    Date::ABBR_MONTHNAMES[number]
  end
  
  def next
    self.class.from(start_date.next_month) # @start_date >> 1
  end
  
  def prev
    self.class.from(start_date.prev_month) # @start_date << 1
  end
  
  def weeks
    Week.from(start_date)..Week.from(end_date)
  end
  
  def each_week(&block)
    weeks.each(&block)
  end
  
  alias_method :month, :number
  alias_method :succ, :next
  alias_method :pred, :prev

  private
  
  def self.initialization_parameter(date)
    [date.year, date.month]
  end
end
