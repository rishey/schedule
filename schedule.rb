require 'Date'
require './helpers.rb'

class Interface
  attr_reader :args
  attr_accessor :parameters

  def initialize args
    @args = args
    @helpText = "usage: schedule.rb [help]
                    [-s start_date] [-f frequency] [-d day_of_week]
                    No Arguments runs defaults -s today -f bi-weekly -d friday\n"
    # @parameters = {}

    if self.help?
      # print @helpText
    elsif default?
      # p getSchedule
    else
      self.parse
      # if parse == false then means bad commands = error
      # p getSchedule

    end

  end

  def parse
    if @args[0].downcase == "-s"  # && parseDate(@args[1]))
      p @args
      startDate = parseDate(@args[1])
      p "#{startDate} is STARTDATE"
      @parameters = {:startDate=>startDate, :frequency=>"bi-weekly", :dayOfWeek=>"friday"}
    else
      return false
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

  # def parameters
  #   if self.default?
  #     {:startDate=>"today", :frequency=>"bi-weekly", :dayOfWeek=>"friday"}
  #   end
  # end

  def getSchedule
    schedule = []
    startDate = @parameters[:startDate]
    frequency = @parameters[:frequency]
    dayOfWeek = @parameters[:dayOfWeek]

    p startDate = findFriday(startDate)
    p stopDate = startDate.next_year
    p currentPayDate = startDate
    p @parameters

    while currentPayDate < stopDate-1
      schedule.push(currentPayDate)
      currentPayDate += 14
    end

    return schedule
  end

end

# parseDate("03-01-2014")

interface = Interface.new(ARGV)
# p ARGV
# p interface.default?
# p interface.help?
# p interface.parameters
