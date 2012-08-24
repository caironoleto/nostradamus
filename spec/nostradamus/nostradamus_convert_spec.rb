require 'spec_helper'
require 'nostradamus'
require 'nostradamus/convert'

describe Nostradamus::Convert do
  context "convert human time to seconds" do
    it "should parse human time to seconds" do
      described_class.new("12:00", :to => :seconds).should eq 43200
      described_class.new("12:00:00", :to => :seconds).should eq 43200
      described_class.new("12:15", :to => :seconds).should eq 44100
      described_class.new("12:15:15", :to => :seconds).should eq 44115
    end

    context "sum seconds" do
      let :time do
        described_class.new("12:00", :to => :seconds) + 60
      end

      it "should be a instance of Nostradamus::Convert" do
        time.should be_instance_of Nostradamus::Convert
      end

      it "should sum 60 seconds" do
        time.should eq 43260
      end
    end
  end

  context "convert seconds to human time" do
    it "should convert seconds to human time" do
      described_class.new(43200, :to => :human_time, :format => :short).should eq "12:00"
      described_class.new(44100, :to => :human_time).should eq "12:15:00"
      described_class.new(44115, :to => :human_time).should eq "12:15:15"
      described_class.new(44115, :to => :human_time, :format => :short).should eq "12:15"
    end

    context "sum seconds" do
      let :time do
        described_class.new(43200, :to => :human_time, :format => :short) + 60
      end

      it "should be a instance of Nostradamus::Convert" do
        time.should be_instance_of Nostradamus::Convert
      end

      it "should sum 60 seconds" do
        time.should eq 43260
      end
    end
  end
end
