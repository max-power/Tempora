require 'minitest/autorun'
require 'date'
require_relative '../lib/week'  # Adjust the path to where your models are

class WeekTest < Minitest::Test
  def test_initialize_with_year_and_week
    week = Week.new(2025, 52)
    assert_equal 2025, week.year
    assert_equal 52, week.number
    assert_equal 'Week 52, 2025', week.to_s
    assert_equal '2025-W52', week.id
  end

  def test_now_class_method
    week = Week.now
    assert_equal Time.now.year, week.year
    assert_equal Time.now.strftime('%V').to_i, week.number  # Week number based on current time
  end

  def test_from_class_method_with_date
    week = Week.from(Date.new(2025, 12, 25))
    assert_equal 2025, week.year
    assert_equal 52, week.number  # Assuming the date falls into the 52nd week
  end
  
  def test_duration
    week = Week.new(2025, 1)
    assert_equal 7, week.duration
  end
  
  def test_navigation
    week = Week.new(2025, 10)
    assert_equal Week.new(2025,11), week.next
    assert_equal Week.new(2025,9), week.prev
    assert_equal Week.new(2024,52), Week.new(2025,1).prev
  end
  
  def test_id_with_seperator
    week = Week.new(2025,2)
    assert_equal "2025-W02", week.id
    assert_equal "2025/W02", week.id('/')
  end
  
  def test_range_spans_across_years
    start_week = Week.new(2024, 52)
    end_week = Week.new(2025, 1)

    # This range will now work correctly, even across years
    week_range = (start_week..end_week)
    assert_equal 2, week_range.count
  end
  
  def test_range_spans_across_years_53_week_year
    start_week = Week.new(2020, 52)
    end_week = Week.new(2021, 1)

    # This range will now work correctly, even across years
    week_range = (start_week..end_week)
    assert_equal 3, week_range.count
  end
  
end
