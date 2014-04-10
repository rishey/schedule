class Parser
  attr_reader :args

  def initialize args
    @args = args
  end

  def default?
    true
  end
end

