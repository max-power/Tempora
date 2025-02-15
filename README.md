# Tempus

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/tempus`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tempus.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).




🔹 1. Generating Monthly Reports

Useful for finance, sales, employee attendance, or analytics dashboards
Example: Fetch revenue per day for a given month
month = Month.new(Date.new(2025, 2, 6))
sales = { "2025-02-01" => 1000, "2025-02-02" => 2000, "2025-02-10" => 500 } # Sample sales data

month.days.each do |day|
  puts "#{day}: $#{sales[day.to_s] || 0}"
end
📌 Output:

2025-02-01: $1000  
2025-02-02: $2000  
2025-02-03: $0  
...
2025-02-10: $500  


🔹 2. Calendar & Scheduling Systems

Generate a calendar for scheduling shifts, meetings, or events
month = Month.new(Date.today)
puts "📅 Calendar for #{month.name} #{month.start_date.year}"
month.weeks.each { |week| puts week.to_s }
📌 Output:

📅 Calendar for February 2025  
Week 5 of 2025: 2025-01-27 to 2025-02-02  
Week 6 of 2025: 2025-02-03 to 2025-02-09  
...
➡️ Could be used in a Rails view to generate a full calendar!

🔹 3. Recurring Events & Subscriptions

Automate billing cycles, gym memberships, or SaaS renewals
def next_billing_cycle(start_date)
  Month.new(start_date).next_month.start_date
end

puts next_billing_cycle(Date.today) # => 2025-03-01
➡️ Use this for subscription renewals, invoice due dates, etc.

🔹 4. Employee Shift Management

Organize employees' shifts week-by-week in a month
month = Month.new(Date.new(2025, 2, 6))
shifts = {
  "2025-02-05" => "John",
  "2025-02-10" => "Anna"
}

month.each_day do |day|
  puts "#{day}: #{shifts[day.to_s] || 'No Shift'}"
end
➡️ Helps in HR systems for workforce planning.

🔹 5. Generating Reports for a Quarter

Combine Month with a Quarter class to analyze quarterly data
class Quarter
  def initialize(date = Time.now)
    @start_date = date.beginning_of_quarter
    @end_date = date.end_of_quarter
  end

  def months
    (0..2).map { |i| Month.new(@start_date + i.months) }
  end
end

q = Quarter.new(2025, 1)
q.months.each { |m| puts m.to_s }
➡️ Use this for quarterly earnings, tax calculations, and budget planning.

