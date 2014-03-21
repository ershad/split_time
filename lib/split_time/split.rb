module SplitTime
  class TimeSpan
      COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
      MONTHS = [nil, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'July', 'Aug', 'Sept', 'Oct' , 'Nov', 'Dec']

      def initialize(start_date, end_date)
        @start_date = Date.parse start_date
        @end_date = Date.parse end_date
      end

   def compute
    hash = {}
    @years = (@start_date.year..@end_date.year).to_a

    (@start_date.year..@end_date.year).to_a.each do |year|
      hash.merge!({year => years(year)})
    end

    puts hash.inspect
   end

   private

   def years(year)
    c_months = months(year)
    c_days   = days(year)

    if c_months == "full year" && c_days == "full months"
      "FULL YEAR"
    else
      if c_days.is_a?(Array)
        if @years.first == year
          { months: c_months , "days in #{c_months.first}, #{year}" => c_days }
        else
          { months: c_months , "days in #{c_months.last}, #{year}" => c_days }
        end
      else
        { months: c_months , days: c_days  }
      end
    end
   end


    def days_in_month(month, year = Time.now.year)
       return 29 if month == 2 && Date.gregorian_leap?(year)
       COMMON_YEAR_DAYS_IN_MONTH[month]
    end

   def months(year)
    s = if @years.last == year
      (1..(@end_date.month)).to_a
    elsif @years.first == year
      ((@start_date.month)..12).to_a
    else
      (1..12).to_a
    end

    if s.count == 12
      "full year"
    else
      s.map{|x|MONTHS[x]}
    end
   end

   def days(year)
    s = if @years.last == year
      (1..(@end_date.day)).to_a
    elsif @years.first == year
      ((@start_date.day)..days_in_month(@start_date.month, @start_date.year)).to_a
    else
      (1..days_in_month(@start_date.month, @start_date.year)).to_a
    end

    if s.count == days_in_month(@start_date.month, @start_date.year)
      if months(year) == "full year"
        "full months"
      else
        if @years.first == year
          "All days of #{MONTHS[@start_date.month]}, #{year}"
        else
          "All days of #{MONTHS[@end_date.month]}, #{year}"
        end
      end
    else
      s
    end
   end
  end
end