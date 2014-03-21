require 'ostruct'

module SplitTime
  class Compute

    def initialize(start_date, end_date)
      @start_date = parse_date start_date
      @end_date   = parse_date end_date

      @years = ( @start_date.year .. @end_date.year ).to_a
    end

    def time_span
      @years.inject({}) do |hash, year|
        hash.merge({year => years(year)})
      end
    end

    private

    def parse_date(date)
      OpenStruct.new Date._parse(date)
    end

    def compute_month(months, start_or_end, c_days, all_days_for_all = false)
      months.inject({}) do |hash, month|
        hash.merge!({
          month => { days: (start_or_end == month && c_days.is_a?(Array) ? c_days : "all_days" ) }
        })
      end
    end

   def years(year)
    c_months = months(year)
    c_days   = days(year)

    if c_months == "full year" && c_days == "full months"
      "full_year"
    else
      compute_month(c_months, (@years.first == year ? c_months.first : c_months.last), c_days)
    end
   end

   def months(year)
    months_ids = case year
    when @years.last
      ( 1 .. @end_date.mon ).to_a
    when @years.first
      ( @start_date.mon .. 12 ).to_a
    else
      ( 1 .. 12 ).to_a
    end

    if months_ids.count == 12
      "full year"
    else
      months_ids.map{ |month_id| SplitTime::Months.all[month_id] }
    end
   end

   def days(year)
    month_days = case year
    when @years.last
      ( 1 .. @end_date.mday ).to_a
    when @years.first
      ( @start_date.mday .. SplitTime::Months.days_in_month(@start_date.mon, @start_date.year) ).to_a
    else
      ( 1 .. SplitTime::Months.days_in_month(@start_date.mon, @start_date.year) ).to_a
    end

    if month_days.count == SplitTime::Months.days_in_month(@start_date.mon, @start_date.year)
      if months(year) == "full year"
        "full months"
      else
        ""
      end
    else
      month_days
    end
   end
  end
end