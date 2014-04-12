require 'Date'
require './helpers.rb'

class Interface
  attr_reader :args

  def initialize args
    @args = args
    @helpText = "usage: schedule.rb [help]
                    [-s start_date] [-f frequency] [-d day_of_week]
                    No Arguments runs defaults -s today -f bi-weekly -d friday\n"

    if self.help?
      print @helpText
    end

  end

  def default?
    if @args.count == 0
      true
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

  def parameters
    if self.default?
      {:startDate=>"today", :frequency=>"bi-weekly", :dayOfWeek=>"friday"}
    end
  end

  def getSchedule
    schedule = []
    startDate = self.parameters[:startDate]
    frequency = self.parameters[:frequency]
    dayOfWeek = self.parameters[:dayOfWeek]

    if startDate.downcase == "today"
      startDate = Date.today
    end

    startDate = findFriday(startDate)
    stopDate = startDate.next_year
    currentPayDate = startDate

    while currentPayDate < stopDate-1
      schedule.push(currentPayDate)
      currentPayDate += 14
    end

    schedule
  end

end

parseDate("03-01-2014")

# interface = Interface.new(ARGV)
# p ARGV
# p interface.default?
# p interface.help?
# p interface.parameters
