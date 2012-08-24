module Nostradamus
  class Convert
    HOURS_REGEX   = /^([0-9]*):.*/
    MINUTES_REGEX = /[0-9]*:([0-9]*).*/
    SECONDS_REGEX = /[0-9]*:[0-9]*:([0-9]*)/

    def initialize(time, params = {})
      @time = time
      @params = params
    end

    def ==(value)
      convert == value
    end

    def +(value)
      self.class.new(time_in_seconds + value)
    end

    private

    def convert
      if @params[:to] == :human_time
        hours, minutes, seconds = extract_time_from_seconds(time_in_seconds)

        if @params[:format] && @params[:format] == :short
          "#{hours}:#{"%02d" % minutes}"
        else
          "#{hours}:#{"%02d" % minutes}:#{"%02d" % seconds}"
        end
      else
        time_in_seconds
      end
    end

    def time_in_seconds
      @seconds ||= if @params[:to] == :seconds
                     hours = extract_hours_from_human_time(@time)
                     minutes = extract_minutes_from_human_time(@time)
                     seconds = extract_seconds_from_human_time(@time)

                     (hours * 3600) + (minutes * 60) + (seconds)
                   else
                     @time
                   end
    end

    def extract_hours_from_human_time(time)
      time.match(HOURS_REGEX)
      matched($1)
    end

    def extract_minutes_from_human_time(time)
      time.match(MINUTES_REGEX)
      matched($1)
    end

    def extract_seconds_from_human_time(time)
      time.match(SECONDS_REGEX)
      matched($1)
    end

    def matched(extracted)
      (extracted || 0).to_i
    end

    def extract_time_from_seconds(seconds)
      [(seconds / 3600), ((seconds / 60) % 60), (seconds % 60)]
    end
  end
end
