require 'nostradamus/convert'

module Nostradamus
  extend self

  def parse(human_time)
    if human_time
      Convert.new(human_time, :to => :seconds)
    end
  end

  def humanize(seconds, format = nil)
    if seconds
      Convert.new(seconds, :to => :human_time, :format => format)
    end
  end
end
