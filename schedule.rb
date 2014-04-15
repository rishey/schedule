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
      @args[0] = "bi-weekly"
    end

    if @args[1] == nil
      @parameters[:startDate] = Date.today
      @parameters[:frequency] = args[0]
    end

    # p @parameters = {:startDate=>parseDate(args[1]), :frequency=>args[0]}

    # if @args[1]!= nil
    #   if startDate = parseDate(@args[1])
    #     @parameters = {:startDate=>startDate, :frequency=>"bi-weekly"}
    #   elsif @args[1] == nil
    #     # @parameters = {:startDate=>Date.today, :frequency=>"bi-weekly"}
    #     @args[1] = Date.today
    #   else
    #     false
    #   end
    # end

    # if @args[0] == nil
    #   @args[0] = "bi-weekly"
    # elsif @args[0] != nil && @args[0].downcase == "daily"
    #   @parameters = {:startDate=>Date.today, :frequency=>"daily"}
    # elsif @args[0] != nil && @args[0].downcase == "weekly"
    #   @parameters = {:startDate=>Date.today, :frequency=>"weekly"}
    # elsif @args[0] != nil && @args[0].downcase == "semi-monthly"
    #   @parameters = {:startDate=>Date.today, :frequency=>"semi-monthly"}
    # elsif @args[0] != nil && @args[0].downcase == "monthly"
    #   @parameters = {:startDate=>Date.today, :frequency=>"monthly"}
    # elsif @args[0] != nil && @args[0].downcase == "bi-weekly"
    #   @parameters = {:startDate=>Date.today, :frequency=>"bi-weekly"}
    # else
    #   false
    # end
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
p [$frequency,$startDate]
Interface.new([$frequency,$startDate])

