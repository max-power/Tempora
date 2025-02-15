# Tempus

Tempus is a lightweight Ruby library for handling months, weeks, quarters, and years with intuitive date-based calculations and range support.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add tempus
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install tempus
```

## Usage

### Initialization

```
year     = Year.new(2025)
month    = Month.new(2025, 12)
week     = Week.new(2025, 52)
quarter  = Quarter.new(2025, 4)
```

Initialization with a Date or Time
```
year     = Year.from Time.now
month    = Month.from Date.today
week     = Week.from Date.new(2025,1,1)
quarter  = Quarter.from Date.today
```

Convenient `.now` method (aliased as `.current`)
```
year     = Year.now
month    = Month.now
week     = Week.now
quarter  = Quarter.now
```

### Navigation

Previous/Next
```
month    = Month.now
next     = month.next  # alias: month.succ
prev     = month.prev  # alias: month.pred
```

Use it in ranges
```
range = Month.new(2025, 1)..Month.new(2025, 6)
range.count            # => 6
range.to_a.map(&:to_s) # => ["January 2025", "February 2025", "March 2025", "April 2025", "May 2025", "June 2025"]
```

Start date / End date
```
month = Month.now
month.start_date # alias: month.begin
month.end_date   # alias: month.end

Month.now.weeks.map(&:start_date)
```

###


## 1. Generating Monthly Reports

Useful for finance, sales, employee attendance, or analytics dashboards
Example: Fetch revenue per day for a given month

```
month = Month.new(2025, 2)
sales = { "2025-02-01" => 1000, "2025-02-02" => 2000, "2025-02-10" => 500 } # Sample sales data

month.days.each do |day|
  puts "#{day}: $#{sales[day.to_s] || 0}"
end
```

📌 Output:
```
2025-02-01: $1000  
2025-02-02: $2000  
2025-02-03: $0  
...
2025-02-10: $500  
```

## 2. Calendar & Scheduling Systems

Generate a calendar for scheduling shifts, meetings, or events

```
month = Month.from(Date.today)
puts "📅 Calendar for #{month}"
month.weeks.each { |week| puts week.to_s }
```

📌 Output:
```
📅 Calendar for February 2025
Week 5, 2025
Week 6, 2025
Week 7, 2025
Week 8, 2025
Week 9, 2025
...
```

➡️ Could be used in a Rails view to generate a full calendar!

## 3. Recurring Events & Subscriptions

Automate billing cycles, gym memberships, or SaaS renewals

```
def next_billing_cycle(start_date)
  Month.from(start_date).next.start_date
end

puts next_billing_cycle(Date.today) # => 2025-03-01
```

➡️ Use this for subscription renewals, invoice due dates, etc.

## 4. Employee Shift Management

Organize employees' shifts week-by-week in a month

```
month = Month.new(2025, 2)
shifts = {
  "2025-02-05" => "John",
  "2025-02-10" => "Anna"
}

month.each_day do |day|
  puts "#{day}: #{shifts[day.to_s] || 'No Shift'}"
end
```

➡️ Helps in HR systems for workforce planning.


## 5. Generating Reports for a Quarter

Use the Quarter class to analyze quarterly data

```
q = Quarter.new(2025, 1)
q.months.each { |m| puts m.to_s }
q.weeks.each { |w| puts w.to_s }
```

➡️ Use this for quarterly earnings, tax calculations, and budget planning.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/max-power/tempus.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).




