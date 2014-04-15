require 'Date'
require './helpers.rb'
require 'optparse'

class Interface
  attr_reader :args, :helpText, :schedule
  attr_accessor :parameters

  def initialize args
    p @args = args
    p "THOSE WERE THE ARGS"

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
    if @args[0].downcase == "-s"
      if startDate = parseDate(@args[1])
        @parameters = {:startDate=>startDate,:frequency=>"bi-weekly", :dayOfWeek=>"friday"}
      else
        return false
      end
    elsif @args[0].downcase == "-f" && @args[1].downcase == "daily"
      @parameters = {:startDate=>Date.today, :frequency=>"daily"}
    elsif @args[0].downcase == "-f" && @args[1].downcase == "weekly"
      @parameters = {:startDate=>Date.today, :frequency=>"weekly"}
    elsif @args[0].downcase == "-f" && @args[1].downcase == "semi-monthly"
      @parameters = {:startDate=>Date.today, :frequency=>"semi-monthly"}
    elsif @args[0].downcase == "-f" && @args[1].downcase == "monthly"
      @parameters = {:startDate=>Date.today, :frequency=>"monthly"}
    elsif @args[0].downcase == "-f" && @args[1].downcase == "bi-weekly"
      @parameters = {:startDate=>Date.today, :frequency=>"bi-weekly"}
    else
      false
    end
  end

  def default?
    if @args[0] == nil && @args[1] == nil
      @parameters = {:startDate=>Date.today, :frequency=>"bi-weekly", :dayOfWeek=>"friday"}
      return true
    else
      false
    end
  end



  def getSchedule
    schedule = []
    startDate = @parameters[:startDate]
    frequency = @parameters[:frequency]
    dayOfWeek = @parameters[:dayOfWeek]

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
  o.on('-s STARTDATE') { |startDate| $startDate = startDate }
  o.on('-f FREQUENCY') { |frequency| $frequency = frequency }
  o.on('-help') { puts o; exit }
  o.parse!
end
p $startDate
p $frequency
p ARGV
Interface.new([$frequency,$startDate])
# if i.help?
#   print i.helpText
# end
# p i.schedule

# p ARGV
# p interface.default?
# p interface.help?
# p interface.parameters
