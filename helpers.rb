def findFriday(date)
  # checks if date is friday, if not checks to find the next
  # friday and returns it.
  until date.friday?
    date += 1
  end
  date
end

def parseDate(dateString)
  parseHash={}
  if (parseHash=dateString.match('(\d\d)[\/\-\.]?(\d\d)[\/\-\.]?(\d{4})'))
    return parseHash
  else
    return false
  end
end