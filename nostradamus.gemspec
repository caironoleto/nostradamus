# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'nostradamus/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Cairo Noleto"]
  gem.email         = ["caironoleto@gmail.com"]
  gem.description   = %q{Time calculation}
  gem.summary       = %q{Time calculation}
  gem.homepage      = "https://github.com/caironoleto/nostradamus"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "nostradamus"
  gem.require_paths = ["lib"]
  gem.version       = Nostradamus::Version::STRING

  gem.add_dependency 'activesupport', '>= 3.2.8'
  gem.add_dependency 'tzinfo', '>= 0.3.35'

  gem.add_development_dependency 'rspec', '>= 2.11.0'
end
