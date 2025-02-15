module HasMonths
  def months
    Month.from(start_date)..Month.from(end_date)
  end

  def each_month(&block)
    months.each(&block)
  end
end
