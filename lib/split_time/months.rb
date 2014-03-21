module SplitTime
  class Months
    COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    def self.all
      [nil, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'July', 'Aug', 'Sept', 'Oct' , 'Nov', 'Dec']
    end

    def self.days_in_month(month, year = Time.now.year)
      return 29 if month == 2 && Date.gregorian_leap?(year)
      COMMON_YEAR_DAYS_IN_MONTH[month]
    end
  end
end