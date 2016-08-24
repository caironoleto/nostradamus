require 'date'

class Nostradamus
  HOURS_REGEX   = /^([0-9]*):.*/
  MINUTES_REGEX = /[0-9]*:([0-9]*).*/
  SECONDS_REGEX = /[0-9]*:[0-9]*:([0-9]*)/

  def self.parse(human_time)
    if human_time
      new(human_time).to_i
    end
  end

  def self.humanize(seconds, format = nil)
    if seconds
      new(seconds).to_s(format)
    end
  end

  def initialize(time)
    @time = time
  end

  def ==(value)
    to_i == self.class.new(value).to_i
  end

  def +(value)
    self.class.new(time_in_seconds + value.to_i)
  end

  def <(value)
    to_i < self.class.new(value).to_i
  end

  def >(value)
    to_i > self.class.new(value).to_i
  end

  def to_i
    time_in_seconds
  end

  def to_s(format = nil)
    hours, minutes, seconds = extract_time_from_seconds(time_in_seconds)

    if format == :short
      "#{hours}:#{"%02d" % minutes}"
    else
      "#{hours}:#{"%02d" % minutes}:#{"%02d" % seconds}"
    end
  end

  def to_time(params = {})
    date = params[:on] || Date.today
    hours, minutes, seconds = extract_time_from_seconds(time_in_seconds)

    Time.utc(date.year, date.month, date.day, hours, minutes)
  end

  private

  def time_in_seconds
    @seconds ||= if @time.is_a?(String)
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
