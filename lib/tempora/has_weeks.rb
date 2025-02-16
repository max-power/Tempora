require 'week'

module Tempora
  module HasWeeks
    def weeks
      Week.from(start_date)..Week.from(end_date)
    end

    def each_week(&block)
      weeks.each(&block)
    end
  end
end