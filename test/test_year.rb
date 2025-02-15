require 'minitest/autorun'
require 'date'
require_relative '../lib/year'  # Adjust the path to where your models are

class YearTest < Minitest::Test
  def test_initialize_with_year
    year = Year.new(2024)
    assert_equal 2024, year.year
    assert_equal 2024, year.id
    assert_equal '2024', year.to_s
  end

  def test_now_class_method
    year = Year.now
    assert_equal Time.now.year, year.year  # Check if it matches current year
  end

  def test_from_class_method_with_date
    year = Year.from Date.new(2024, 5, 10)
    assert_equal 2024, year.year
  end
  
  def test_duration
    year = Year.new(2025)
    leap = Year.new(2024)
    
    assert_equal 365, year.duration
    assert_equal 366, leap.duration
  end
  
  def test_navigation
    year = Year.new(2025)
    assert_equal 2026, year.next.year
    assert_equal 2024, year.prev.year
  end
  
  def test_months
    year = Year.new(2025)
    assert_equal year.months.count, 12
  end
  
  def test_weeks
    year = Year.new(2025)
    assert_equal year.weeks.count, 52
  end
end
