require 'spec_helper'

describe Nostradamus do
  context "#parse" do
    it "should parse human time to seconds" do
      expect(described_class.parse("12:00")).to eq 43200
      expect(described_class.parse("12:00:00")).to eq 43200
      expect(described_class.parse("12:15")).to eq 44100
      expect(described_class.parse("12:15:15")).to eq 44115
    end

    it "should not raise error without value" do
      expect {
        described_class.parse(nil)
      }.to_not raise_error
    end
  end

  context "#humanize" do
    it "should convert seconds to human time" do
      expect(described_class.humanize(43200, :short)).to eq "12:00"
      expect(described_class.humanize(44100)).to eq "12:15:00"
      expect(described_class.humanize(44115)).to eq "12:15:15"
      expect(described_class.humanize(44115, :short)).to eq "12:15"
    end

    it "should not raise error without value" do
      expect {
        described_class.humanize(nil)
      }.to_not raise_error
    end
  end

  context "convert human time to seconds" do
    it "should compare human time to seconds" do
      expect(described_class.new("12:00")).to eq 43200
      expect(described_class.new("12:00:00")).to eq 43200
      expect(described_class.new("12:15")).to eq 44100
      expect(described_class.new("12:15:15")).to eq 44115
    end

    context "less (<)" do
      it "should be less than 44115 seconds" do
        expect(described_class.new("12:00")).to be < 44115
      end

      it "should not be less than" do
        expect(described_class.new("12:00")).to_not be < 40115
      end
    end

    context "greater (<)" do
      it "should be greater than" do
        expect(described_class.new("12:00")).to be > 40115
      end

      it "should not be greater than" do
        expect(described_class.new("12:00")).to_not be > 44115
      end
    end

    context "#to_i" do
      it "should return seconds" do
        expect(described_class.new("12:15:15").to_i).to eq 44115
      end
    end

    context "#to_s" do
      subject do
        described_class.new("12:00")
      end

      it "should return formatted time with seconds" do
        expect(subject.to_s).to eq "12:00:00"
      end

      it "should return short formatted time" do
        expect(subject.to_s(:short)).to eq "12:00"
      end
    end

    context "sum seconds" do
      let :time do
        described_class.new("12:00") + 60
      end

      it "should be a instance of Nostradamus" do
        expect(time).to be_instance_of Nostradamus
      end

      it "should sum 60 seconds" do
        expect(time).to eq 43260
      end
    end

    context "sum with another Nostradamus instance" do
      let :time do
        described_class.new("12:00") + described_class.new("00:00:60")
      end

      it "should be a instance of Nostradamus" do
        expect(time).to be_instance_of Nostradamus
      end

      it "should sum 60 seconds" do
        expect(time).to eq 43260
      end
    end
  end

  context "convert seconds to human time" do
    it "should compare seconds to human time" do
      expect(described_class.new(43200)).to eq "12:00"
      expect(described_class.new(44100)).to eq "12:15:00"
      expect(described_class.new(44100)).to eq "12:15"
      expect(described_class.new(44115)).to eq "12:15:15"
    end

    context "less (<)" do
      it "should be less than 44115 seconds" do
        expect(described_class.new(43200)).to be < 44115
      end

      it "should not be less than" do
        expect(described_class.new(43200)).to_not be < 40115
      end
    end

    context "greater (<)" do
      it "should be greater than" do
        expect(described_class.new(43200)).to be > 40115
      end

      it "should not be greater than" do
        expect(described_class.new(43200)).to_not be > 44115
      end
    end

    context "#to_i" do
      it "should return seconds" do
        expect(described_class.new(44115).to_i).to eq 44115
      end
    end

    context "#to_s" do
      subject do
        described_class.new(44115)
      end

      it "should return formatted time with seconds" do
        expect(subject.to_s).to eq "12:15:15"
      end

      it "should return short formatted time" do
        expect(subject.to_s(:short)).to eq "12:15"
      end
    end

    context "sum seconds" do
      let :time do
        described_class.new(43200) + 60
      end

      it "should be a instance of Nostradamus" do
        expect(time).to be_instance_of Nostradamus
      end

      it "should sum 60 seconds" do
        expect(time).to eq 43260
      end
    end

    context "sum with another Nostradamus instance" do
      let :time do
        described_class.new(43200) + described_class.new(60)
      end

      it "should be a instance of Nostradamus" do
        expect(time).to be_instance_of Nostradamus
      end

      it "should sum 60 seconds" do
        expect(time).to eq 43260
      end
    end
  end

  context "convert seconds to time object" do
    context "without a base date" do
      let :today do
        Date.today
      end

      it "return a today time object" do
        expect(described_class.new(43200).to_time).to eq Time.utc(today.year, today.month, today.day, 12, 0)
        expect(described_class.new("12:00").to_time).to eq Time.utc(today.year, today.month, today.day, 12, 0)
      end
    end

    context "with a base date" do
      let :date do
        Date.new(2012, 10, 1)
      end

      it "uses a date to return a time object" do
        expect(described_class.new(43200).to_time(:on => date)).to eq Time.utc(date.year, date.month, date.day, 12, 0)
        expect(described_class.new("12:00").to_time(:on => date)).to eq Time.utc(date.year, date.month, date.day, 12, 0)
      end
    end
  end
end
