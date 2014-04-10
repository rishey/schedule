class Parser
  attr_reader :args

  def initialize args
    @args = args
  end

  def default?
    if @args.count == 0
      true
    else
      false
    end
  end

  def help?
    # if @args[0].downcase == "help" || @args[0].downcase == "-help"
    if @args[0].downcase.match('\A-{0,2}help\z')
      true
    else
      false
    end
  end

end

