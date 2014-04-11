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
    if @args.count == 0
      false
    elsif @args[0].downcase.match('\A-{0,2}help\z') || @args[0] == "?"
      true
    else
      false
    end
  end

end

parser = Parser.new(ARGV)
p parser.default?
p parser.help?
