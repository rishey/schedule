require "./schedule.rb"

# TESTING WITH NO ARGUMENTS


describe Parser do

  context "No Arguments" do

    cmdLineArgs = []
    parser = Parser.new(cmdLineArgs)

    it "contains the command line arguments passed in in an array called args" do
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

      it "returns false for the method default?" do
        expect(parser.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(parser.help?).to eq(true)
      end

    end

    context "Help argument lowercase" do
      cmdLineArgs = ["help"]
      parser = Parser.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(parser.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(parser.help?).to eq(true)
      end

    end

    context "Help argument mixed case" do
      cmdLineArgs = ["Help"]
      parser = Parser.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(parser.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(parser.help?).to eq(true)
      end

    end

    context "Help argument preceeded by single dash" do
      cmdLineArgs = ["-HELP"]
      parser = Parser.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(parser.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(parser.help?).to eq(true)
      end

    end

    context "Help argument preceeded by double dash" do
      cmdLineArgs = ["--HELP"]
      parser = Parser.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(parser.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(parser.help?).to eq(true)
      end
    end

    context "Help argument preceeded by tripple dash" do
      cmdLineArgs = ["---HELP"]
      parser = Parser.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(parser.default?).to eq(false)
      end

      it "returns a false value for help?" do
        expect(parser.help?).to eq(false)
      end
    end

    context "help argument as question mark" do
      cmdLineArgs = ["?"]
      parser = Parser.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(parser.default?).to eq(false)
      end

      it "returns a false value for help?" do
        expect(parser.help?).to eq(true)
      end
    end

  end

end