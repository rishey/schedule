class Interface
  attr_reader :args, :helpText

  def initialize args
    @args = args
    @helpText = "This is line 1 of help text.\nThis is line 2.\n"
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
    {:startDate=>"today", :frequency=>"bi-weekly", :dayOfWeek=>"friday"}
  end

end

interface = Interface.new(ARGV)
p interface.default?
p interface.help?

