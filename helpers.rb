def findFriday(date)
  # checks if date is friday, if not checks to find the next
  # friday and returns it.
  until date.friday?
    date += 1
  end
  date
end

def parseDate(dateString)
  dateHash = {}
  if (dateHash=dateHashString.match('(\d\d)[\/\-\.]?(\d\d)[\/\-\.]?(\d{4})'))
    month = dateHash[1].to_i
    day = dateHash[2].to_i
    year = dateHash[3].to_i
    p Date.valid_date?(year,month,day)
    p "that was the valid date t or f"
    return Date.new(year,month,day)
  else
    return false
  end
end