require 'date'

module Initialization
  def now
    from Time.now
  end
  
  alias_method :current, :now
  
  def from(date)
    new *initialization_parameter(date.to_date)
  end
  
  private
  
  def initialization_parameter(date)
    [date.year]
  end
end