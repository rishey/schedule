def findFriday(date)
  # checks if date is friday, if not checks to find the next
  # friday and returns it.
  until date.friday?
    date += 1
  end
  date
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