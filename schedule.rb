require 'Date'
require './helpers.rb'

class Interface
  attr_reader :args, :schedule
  attr_accessor :parameters

  def initialize args
    @args = args
    @helpText = "usage: schedule.rb [help]
                    [-s start_date] [-f frequency] [-d day_of_week]
                    No Arguments runs defaults -s today -f bi-weekly -d friday\n"
    @parameters = {}

    if self.help?
      @helpText
    elsif default?
      schedule = getSchedule
      # schedule.each do |date|
      #   p date.to_s
      # end
    elsif parse
      # if parse == false then means bad commands = error
      getSchedule
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
    else
      false
    end
  end

  def default?
    if @args.count == 0
      @parameters = {:startDate=>Date.today, :frequency=>"bi-weekly", :dayOfWeek=>"friday"}
      return true
    else
      false
    end
  end

  def help?
    if @args.count == 0
      false
    elsif @args[0].downcase.match('\A-{0,2}help\z') || @args[0] == "?"
      true
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
    end

    schedule
  end

end

Interface.new(ARGV)
# p ARGV
# p interface.default?
# p interface.help?
# p interface.parameters
