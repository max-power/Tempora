require 'minitest/autorun'
require 'date'
require_relative '../lib/quarter'  # Adjust the path to where your models are

class QuarterTest < Minitest::Test
  def test_initialize_with_year_and_quarter
    quarter = Quarter.new(2025, 3)
    assert_equal 2025, quarter.year
    assert_equal 3, quarter.number
    assert_equal 'Q3 2025', quarter.to_s
    assert_equal '2025-Q3', quarter.id
  end

  def test_now_class_method
    quarter = Quarter.now
    assert_equal Time.now.year, quarter.year
    assert_equal ((Time.now.month - 1) / 3) + 1, quarter.number
  end

  def test_from_class_method_with_date
    quarter = Quarter.from(Date.new(2025, 5, 15))
    assert_equal 2025, quarter.year
    assert_equal 2, quarter.number  # Since May is in the 2nd quarter
  end
  
  def test_duration
    year = Quarter.new(2025, 1)
    leap = Quarter.new(2024, 1)
    
    assert_equal 90, year.duration
    assert_equal 91, leap.duration
  end
  
  def test_navigation
    quarter = Quarter.new(2025,2)
    assert_equal Quarter.new(2025,3), quarter.next
    assert_equal Quarter.new(2025,1), quarter.prev
    assert_equal Quarter.new(2024,4), quarter.prev.prev
  end
  
  def test_id_with_seperator
    quarter = Quarter.new(2025,2)
    assert_equal "2025-Q2", quarter.id
    assert_equal "2025/Q2", quarter.id('/')
  end
end
