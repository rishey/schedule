require "./schedule.rb"

# TESTING WITH NO ARGUMENTS


describe Parser do

  context "No Arguments" do

    cmdLineArgs = []
    parser = Parser.new(cmdLineArgs)

    it "contains the command linearguments passed in in an array called args" do
      expect(parser.args).to eq(cmdLineArgs)
    end

    it "contains the same number of items in parser.args as in cmdLineArgs " do
      expect(parser.args.count).to eq(cmdLineArgs.count)
    end

    it "returns true for method default? if there are no cmdLineArgs" do
      expect(parser.default?).to eq(true)
    end

  end

  context "Help given as single argument" do

    context "Help argument uppercase" do

      cmdLineArgs = ["HELP"]
      parser = Parser.new(cmdLineArgs)

      it "returns a true value for help?" do
        expect(parser.help?).to eq(true)
      end

    end

    context "Help argument lowercase" do
    end

    context "Help argument mixed case" do
    end

    context "Help argument preceeded by single dash" do
    end

    context "Help argument preceeded by double dash" do
    end

    context "help argument as single letter h preceeded by single dash" do
    end

    context "help argument as single letter h preceeded by double dash" do
    end

    context "help argument as question mark" do
    end

  end

end