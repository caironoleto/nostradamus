#The Nostradamus gem

You can parse human time to seconds or convert seconds to human time.

## Install nostradamus gem

Add `nostradamus` in Gemfile and run `bundle install`.

	gem "nostradamus"

Or only execute `gem install nostradamus` on terminal.

## How to use

### Human time to seconds:
```
Nostradamus.parse("10:00") # => 36000
Nostradamus.parse("10:00:00") # => 36000
```

### Seconds to human time:
```
Nostradamus.humanize(36000, :short) # => "10:00"
Nostradamus.humanize(36000) # => "10:00:00"
```

### Sum with seconds
```
time = Nostradamus.new("12:00") + 60
time.to_i # => 43260
time.to_s # => "12:01:00"
time.to_s(:short) # => "12:01"
```

### Sum with another Nostradamus instance
```
time = Nostradamus.new("12:00") + Nostradamus.new(60)
time.to_i # => 43260
time.to_s # => "12:01:00"
time.to_s(:short) # => "12:01"
```

### Compare times
```
Nostradamus.new("12:00") == 43260
Nostradamus.new("00:01:00") == Nostradamus.new(60)
```

### Returning a Time object
```
Nostradamus.new("12:00").to_time # => Returns a object: Time.new(CURRENT_YEAR, CURRENT_MONTH, CURRENT_DAY, 12, 0)
Nostradamus.new("12:00").to_time(:on => Date.new(2012, 5, 1)) # => Returns a object: Time.new(2012, 5, 1, 12, 0)
```

## Contributions

If you want contribute, please:

	* Fork the project.
	* Make your feature addition or bug fix.
	* Send me a pull request on Github.

## Code Status

[![Build Status](https://travis-ci.org/caironoleto/nostradamus.svg?branch=master)](https://travis-ci.org/caironoleto/nostradamus)
