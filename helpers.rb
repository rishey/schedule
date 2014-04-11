def findFriday(date)
  # checks if date is friday, if not checks to find the next
  # friday and returns it.
  until date.friday?
    date += 1
  end
  date
end

p findFriday(Date.today)