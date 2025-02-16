module Tempora
  module HasDays
    def days
      range.to_a
    end

    def each_day(&block)
      range.each(&block)
    end
  end
end