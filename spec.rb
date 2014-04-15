require "./schedule.rb"
require 'Date'

# TESTING  INTERFACE WITH NO ARGUMENTS

describe Interface do

  context "No Arguments" do

    cmdLineArgs = []
    interface = Interface.new(cmdLineArgs)

    describe "#initialize" do
      it "contains the command line arguments passed in in an array called args" do
        expect(interface.args).to eq(cmdLineArgs)
      end

      it "contains the same number of items in interface.args as in cmdLineArgs " do
        expect(interface.args.count).to eq(cmdLineArgs.count)
      end
    end

    describe "#default?" do
      it "returns true if there are no cmdLineArgs" do
        expect(interface.default?).to eq(true)
      end
    end

    describe ".parameters" do
      it "returns a hash" do
        expect(interface.parameters).to be_a(Hash)
      end
    end

    describe "#getSchedule" do
      it "returns array" do
        expect(interface.getSchedule).to be_a(Array)
      end

      it "returns array where first value is = today if friday or next friday" do
        expect(interface.getSchedule).to start_with(findFriday(Date.today))
      end

      it "returns an array where the last value is the 25 Fridays later than the startDate" do
        expect(interface.getSchedule).to end_with(findFriday(Date.today).+350)
      end

      it "returns an array containing 26 pay dates" do
        expect(interface.getSchedule.count).to eq(26)
      end
    end

  end

  context "Bad Arguments" do
    cmdLineArgs = ["adsfdsf", "df3jas"]
    interface = Interface.new(cmdLineArgs)

    describe "#initialize" do
      it "returns false" do
        expect(interface.parse).to eq(false)
      end
    end

  end

  context "Only Start Date Given as Argument" do

    cmdLineArgs = ["-s" ,"03/01/2014"]
    interface = Interface.new(cmdLineArgs)

    describe "#initialize" do
      it "contains the command line arguments passed in in an array called args" do
        expect(interface.args).to eq(cmdLineArgs)
      end

      it "contains the same number of items in interface.args as in cmdLineArgs " do
        expect(interface.args.count).to eq(cmdLineArgs.count)
      end
    end

    describe "#default" do
      it "returns false there are cmd line arguments" do
        expect(interface.default?).to eq(false)
      end
    end

    describe ".parameters" do
      it "returns the the startDate of '03/01/2014'" do
        expect(interface.parameters[:startDate].strftime('%m/%d/%Y')).to eq("03/01/2014")
      end
    end

    describe "#getSchedule" do
      it "returns array" do
        expect(interface.getSchedule).to be_a(Array)
      end

      it "returns array where first value is = today if friday or next friday" do
        expect(interface.getSchedule).to start_with(findFriday(Date.new(2014,03,01)))
      end

      it "returns an array where the last value is the 25 Fridays later than the startDate" do
        expect(interface.getSchedule).to end_with(findFriday(Date.new(2014,03,01)).+350)
      end

      it "returns an array containing 26 pay dates" do
        expect(interface.getSchedule.count).to eq(26)
      end
    end

  end


  context "Help given as first argument" do


    context "Help argument uppercase" do

      cmdLineArgs = ["HELP"]
      interface = Interface.new(cmdLineArgs)

      describe "#default?" do
        it "returns false" do
          expect(interface.default?).to eq(false)
        end
      end

      describe "#help?" do
        it "returns a true" do
          expect(interface.help?).to eq(true)
        end
      end

    end

    context "Help argument lowercase" do
      cmdLineArgs = ["help"]
      interface = Interface.new(cmdLineArgs)

      describe "default?" do
        it "returns false" do
          expect(interface.default?).to eq(false)
        end
      end

      describe "help?" do
        it "returns a true value" do
          expect(interface.help?).to eq(true)
        end
      end

    end

    context "Help argument mixed case" do
      cmdLineArgs = ["Help"]
      interface = Interface.new(cmdLineArgs)

      describe "#default?" do
        it "returns false for the method default?" do
          expect(interface.default?).to eq(false)
        end
      end

      describe "#help?" do
        it "returns a true value for help?" do
          expect(interface.help?).to eq(true)
        end
      end

    end

    context "Help argument preceeded by single dash" do
      cmdLineArgs = ["-HELP"]
      interface = Interface.new(cmdLineArgs)

      describe "#default?" do
        it "returns false" do
          expect(interface.default?).to eq(false)
        end
      end

      describe "#help?" do
        it "returns a true value" do
          expect(interface.help?).to eq(true)
        end
      end

    end

    context "Help argument preceeded by double dash" do
      cmdLineArgs = ["--HELP"]
      interface = Interface.new(cmdLineArgs)

      describe "#default?" do
        it "returns false" do
          expect(interface.default?).to eq(false)
        end
      end

      describe "#help?" do
        it "returns a true value" do
          expect(interface.help?).to eq(true)
        end
      end

    end

    context "Help argument preceeded by tripple dash" do
      cmdLineArgs = ["---HELP"]
      interface = Interface.new(cmdLineArgs)

      describe "#default?" do
        it "returns false" do
          expect(interface.default?).to eq(false)
        end
      end

      describe "#help?" do
        it "returns a false value" do
          expect(interface.help?).to eq(false)
        end
      end

    end

    context "help argument as question mark" do
      cmdLineArgs = ["?"]
      interface = Interface.new(cmdLineArgs)

      describe "#default?" do
        it "returns false" do
          expect(interface.default?).to eq(false)
        end
      end

      describe "#help?" do
        it "returns a false value" do
          expect(interface.help?).to eq(true)
        end
      end

    end

  end


end