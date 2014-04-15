require 'Date'
require './helpers.rb'
require 'optparse'

class Interface
  attr_reader :args, :helpText, :schedule
  attr_accessor :parameters

  def initialize args
    @args = args
    @parameters = {}

    if default?
      printOut(getSchedule)
    elsif parse
      printOut(getSchedule)
    else
      print "\nYou made an entry error. Please try again.\n\n"
      print @helpText
    end
  end

  def parse
    if @args[0] == nil
      @parameters[:frequency] = "bi-weekly"
      @parameters[:startDate] = parseDate(@args[1])
    elsif (@args[0] != "bi-weekly") && (@args[0] != "monthly") && (@args[0] != "weekly") && (@args[0] != "daily") && (@args[0] != "semi-monthly") && (@args[0] != nil)
      return false
    else
      @parameters[:frequency] = @args[0]
      if @args[1] != nil
        @parameters[:startDate] = parseDate(@args[1])
      else
        @parameters[:startDate] = Date.today
      end
      @parameters
    end

    return true
  end

  def default?
    if @args[0] == nil && @args[1] == nil
      @parameters = {:startDate=>Date.today, :frequency=>"bi-weekly"}
      return true
    else
      false
    end
  end

  def getSchedule
    schedule = []
    startDate = @parameters[:startDate]
    frequency = @parameters[:frequency]

    # if startDate.downcase == "today"
    #   startDate = Date.today
    # end
    if frequency.downcase == "bi-weekly"
      startDate = findFriday(startDate)
      stopDate = startDate.next_year
      currentPayDate = startDate
      while currentPayDate < stopDate-1
        schedule.push(currentPayDate)
        currentPayDate += 14
      end
    elsif frequency.downcase == "daily"
      startDate = findNextWeekday(startDate)
      stopDate = startDate.next_year
      currentPayDate = startDate
      while currentPayDate < stopDate - 1
        schedule.push(currentPayDate)
        currentPayDate = findNextWeekday(currentPayDate+1)
      end
    elsif frequency.downcase == "weekly"
      startDate = findFriday(startDate)
      stopDate = startDate.next_year
      currentPayDate = startDate
      while currentPayDate < stopDate - 1
        schedule.push(currentPayDate)
        currentPayDate += 7
      end
    elsif frequency.downcase == "semi-monthly"
      startDate = find1st15th(startDate)
      stopDate = startDate.next_year
      currentPayDate = startDate
      while currentPayDate < (stopDate)
        schedule.push(currentPayDate)
        currentPayDate = find1st15th(currentPayDate + 14)
      end
     elsif frequency.downcase == "monthly"
      startDate = find1st(startDate)
      stopDate = startDate.next_year
      currentPayDate = startDate
      while currentPayDate < (stopDate)
        schedule.push(currentPayDate)
        currentPayDate = find1st(currentPayDate + 25)
      end
    end

    schedule
  end

end

OptionParser.new do |o|
  o.on('-s START DATE in format mm/dd/yyyy') { |startDate| $startDate = startDate }
  o.on('-f FREQUENCY (daily, weekly, bi-weekly, semi-monthly, monthly)') { |frequency| $frequency = frequency }
  o.on('-help') { puts o; exit }
  o.parse!
end
Interface.new([$frequency,$startDate])

