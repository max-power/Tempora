require 'minitest/autorun'
require 'date'
require_relative '../lib/month'  # Adjust the path to where your models are

class MonthTest < Minitest::Test
  def test_initialize_with_year_and_month
    month = Month.new(2024, 4)
    assert_equal 2024, month.year
    assert_equal 4, month.number
    assert_equal 'April 2024', month.to_s
    assert_equal '2024-04', month.id
  end

  def test_now_class_method
    month = Month.now
    assert_equal Time.now.year, month.year
    assert_equal Time.now.month, month.number
  end

  def test_from_class_method_with_date
    month = Month.from(Date.new(2024, 4, 15))
    assert_equal 2024, month.year
    assert_equal 4, month.number
  end
  
  def test_duration
    year = Month.new(2025, 2)
    leap = Month.new(2024, 2)
    
    assert_equal 28, year.duration
    assert_equal 29, leap.duration
  end
  
  def test_navigation
    month = Month.new(2025,2)
    assert_equal Month.new(2025,3), month.next
    assert_equal Month.new(2025,1), month.prev
    assert_equal Month.new(2024,12), month.prev.prev
  end
  
  def test_id_with_seperator
    month = Month.new(2025,2)
    assert_equal "2025-02", month.id
    assert_equal "2025/02", month.id('/')
  end
  
  def test_start_time
    month = Month.new(2025,2)
    assert_equal Time.new(2025,2,1,0,0,0), month.start_time
  end
  
  def test_end_time
    month = Month.new(2025,2)
    assert_equal Time.new(2025,2,28,23,59,59), month.end_time
  end
end
