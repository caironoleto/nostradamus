#The Nostradamus gem 

You can parse human time to seconds or convert seconds to human time.

## Install nostradamus gem

Add `nostradamus` in Gemfile and run `bundle install`.

	gem "nostradamus"

Or only execute `gem install nostradamus` on terminal.

## How to use

### Human time to seconds:

	Nostradamus.parse("10:00") retun 36000
	Nostradamus.parse("10:00:00") retun 36000

### Seconds to human time:
	
	Nostradamus.humanize(36000, :short) return "10:00"
	Nostradamus.humanize(36000) return "10:00:00"

## Contributions

If you wont to contribute, please:

	* Fork the project.
	* Make your feature addition or bug fix.	
	* Send me a pull request on Github.