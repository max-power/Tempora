module Tempora
  module HasTime
    def start_time
      start_date.to_time
    end

    def end_time
      end_date.next_day.to_time - 1
    end
  end
end