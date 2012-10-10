require 'spec_helper'

describe Nostradamus do
  context "#parse" do
    it "should parse human time to seconds" do
      described_class.parse("12:00").should eq 43200
      described_class.parse("12:00:00").should eq 43200
      described_class.parse("12:15").should eq 44100
      described_class.parse("12:15:15").should eq 44115
    end

    it "should not raise error without value" do
      expect {
        described_class.parse(nil)
      }.to_not raise_error
    end
  end

  context "#humanize" do
    it "should convert seconds to human time" do
      described_class.humanize(43200, :short).should eq "12:00"
      described_class.humanize(44100).should eq "12:15:00"
      described_class.humanize(44115).should eq "12:15:15"
      described_class.humanize(44115, :short).should eq "12:15"
    end

    it "should not raise error without value" do
      expect {
        described_class.humanize(nil)
      }.to_not raise_error
    end
  end

  context "convert human time to seconds" do
    it "should compare human time to seconds" do
      described_class.new("12:00").should eq 43200
      described_class.new("12:00:00").should eq 43200
      described_class.new("12:15").should eq 44100
      described_class.new("12:15:15").should eq 44115
    end

    context "#to_i" do
      it "should return seconds" do
        described_class.new("12:15:15").to_i.should eq 44115
      end
    end

    context "#to_s" do
      subject do
        described_class.new("12:00")
      end

      it "should return formatted time with seconds" do
        subject.to_s.should eq "12:00:00"
      end

      it "should return short formatted time" do
        subject.to_s(:short).should eq "12:00"
      end
    end

    context "sum seconds" do
      let :time do
        described_class.new("12:00") + 60
      end

      it "should be a instance of Nostradamus" do
        time.should be_instance_of Nostradamus
      end

      it "should sum 60 seconds" do
        time.should eq 43260
      end
    end

    context "sum with another Nostradamus instance" do
      let :time do
        described_class.new("12:00") + described_class.new("00:00:60")
      end

      it "should be a instance of Nostradamus" do
        time.should be_instance_of Nostradamus
      end

      it "should sum 60 seconds" do
        time.should eq 43260
      end
    end
  end

  context "convert seconds to human time" do
    it "should compare seconds to human time" do
      described_class.new(43200).should eq "12:00"
      described_class.new(44100).should eq "12:15:00"
      described_class.new(44100).should eq "12:15"
      described_class.new(44115).should eq "12:15:15"
    end

    context "#to_i" do
      it "should return seconds" do
        described_class.new(44115).to_i.should eq 44115
      end
    end

    context "#to_s" do
      subject do
        described_class.new(44115)
      end

      it "should return formatted time with seconds" do
        subject.to_s.should eq "12:15:15"
      end

      it "should return short formatted time" do
        subject.to_s(:short).should eq "12:15"
      end
    end

    context "sum seconds" do
      let :time do
        described_class.new(43200) + 60
      end

      it "should be a instance of Nostradamus" do
        time.should be_instance_of Nostradamus
      end

      it "should sum 60 seconds" do
        time.should eq 43260
      end
    end

    context "sum with another Nostradamus instance" do
      let :time do
        described_class.new(43200) + described_class.new(60)
      end

      it "should be a instance of Nostradamus" do
        time.should be_instance_of Nostradamus
      end

      it "should sum 60 seconds" do
        time.should eq 43260
      end
    end
  end

  context "convert seconds to time object" do
    context "without a base date" do
      let :today do
        Date.today
      end

      it "return a today time object" do
        described_class.new(43200).to_time.should eq Time.zone.local(today.year, today.month, today.day, 12, 0)
        described_class.new("12:00").to_time.should eq Time.zone.local(today.year, today.month, today.day, 12, 0)
      end
    end

    context "with a base date" do
      let :date do
        Date.new(2012, 10, 1)
      end

      it "uses a date to return a time object" do
        described_class.new(43200).to_time(:on => date).should eq Time.zone.local(date.year, date.month, date.day, 12, 0)
        described_class.new("12:00").to_time(:on => date).should eq Time.zone.local(date.year, date.month, date.day, 12, 0)
      end
    end
  end
end
