require "./schedule.rb"

# TESTING WITH NO ARGUMENTS


describe Interface do

  context "No Arguments" do

    cmdLineArgs = []
    interface = Interface.new(cmdLineArgs)

    it "contains the command line arguments passed in in an array called args" do
      expect(interface.args).to eq(cmdLineArgs)
    end

    it "contains the same number of items in interface.args as in cmdLineArgs " do
      expect(interface.args.count).to eq(cmdLineArgs.count)
    end

    it "returns true for method default? if there are no cmdLineArgs" do
      expect(interface.default?).to eq(true)
    end

    it "returns the default parameters as a hash" do
      expect(interface.parameters).to eq({:startDate=>"today", :frequency=>"bi-weekly", :dayOfWeek=>"friday"})
    end

  end

  context "Help given as first argument" do

    context "Help argument uppercase" do

      cmdLineArgs = ["HELP"]
      interface = Interface.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(interface.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(interface.help?).to eq(true)
      end

    end

    context "Help argument lowercase" do
      cmdLineArgs = ["help"]
      interface = Interface.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(interface.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(interface.help?).to eq(true)
      end

    end

    context "Help argument mixed case" do
      cmdLineArgs = ["Help"]
      interface = Interface.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(interface.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(interface.help?).to eq(true)
      end

    end

    context "Help argument preceeded by single dash" do
      cmdLineArgs = ["-HELP"]
      interface = Interface.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(interface.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(interface.help?).to eq(true)
      end

    end

    context "Help argument preceeded by double dash" do
      cmdLineArgs = ["--HELP"]
      interface = Interface.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(interface.default?).to eq(false)
      end

      it "returns a true value for help?" do
        expect(interface.help?).to eq(true)
      end
    end

    context "Help argument preceeded by tripple dash" do
      cmdLineArgs = ["---HELP"]
      interface = Interface.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(interface.default?).to eq(false)
      end

      it "returns a false value for help?" do
        expect(interface.help?).to eq(false)
      end
    end

    context "help argument as question mark" do
      cmdLineArgs = ["?"]
      interface = Interface.new(cmdLineArgs)

      it "returns false for the method default?" do
        expect(interface.default?).to eq(false)
      end

      it "returns a false value for help?" do
        expect(interface.help?).to eq(true)
      end
    end

  end

  context ""

end