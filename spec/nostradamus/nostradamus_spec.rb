require 'spec_helper'
require 'nostradamus'

describe Nostradamus do
  context "human time to seconds" do
    it "should parse human time to seconds" do
      described_class.parse("12:00").should eq 43200
      described_class.parse("12:00:00").should eq 43200
      described_class.parse("12:15").should eq 44100
      described_class.parse("12:15:15").should eq 44115
    end
  end

  context "seconds to human time" do
    it "should convert seconds to human time" do
      described_class.humanize(43200, :short).should eq "12:00"
      described_class.humanize(44100).should eq "12:15:00"
      described_class.humanize(44115).should eq "12:15:15"
      described_class.humanize(44115, :short).should eq "12:15"
    end
  end
end
