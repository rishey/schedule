def findFriday(date)
  # checks if date is friday, if not checks to find the next
  # friday and returns it.
  until date.friday?
    date += 1
  end
  date
end

def findPrevWeekday(date)
  # check if date is a weekday, if not, finds the most
  # previous weekday and returns it
  until date.wday != 0 && date.wday != 6
    date -= 1
  end
  date
end

def findNextWeekday(date)
  # check if date is a weekday, if not, finds the
  # next weekday and returns it
  until date.wday != 0 && date.wday != 6
    date += 1
  end
  date
end

def find1st15th(date)
  # check if date is a 1st or 15th of the month
  # if not, find the next 1st or 15th of a month
  # do findPrevWeekday on it to make sure it's not
  # a weekend
  until date.day == 1 || date.day == 15
    date += 1
  end
  findPrevWeekday(date)
end

def find1st(date)
  # check if date is a 1st of the month
  # if not, find the next 1st of a month
  # do findPrevWeekday on it to make sure it's not
  # a weekend
  until date.day == 1
    date += 1
  end
  findPrevWeekday(date)
end

def parseDate(dateString)
  # checks to see if the date is in valid format, then checks to see
  # if it is a valid date. if so, it returns a date object
  dateHash = {}
  if (dateHash = dateString.match('(\d\d)[\/\-\.]?(\d\d)[\/\-\.]?(\d{4})'))
    month = dateHash[1].to_i
    day   = dateHash[2].to_i
    year  = dateHash[3].to_i
    if Date.valid_date?(year,month,day)
      return Date.new(year,month,day)
    else
      return false
    end
  else
    return false
  end
end

def printOut(schedule)
  schedule.each do |payDate|
    p payDate.strftime('%m/%d/%Y')

  end
end