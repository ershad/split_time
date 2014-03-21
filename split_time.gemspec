# -*- encoding: utf-8 -*-
require File.expand_path('../lib/split_time/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ershad K"]
  gem.email         = ["ershad@bangthetable.com"]
  gem.description   = %q{Split time into largest chunks}
  gem.summary       = %q{A ruby gem to split time into largest chunks}
  gem.homepage      = "https://github.com/ershad/split_time"
  gem.licenses      = ["MIT License"]

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "split_time"
  gem.require_paths = ["lib"]
  gem.version       = SplitTime::VERSION

  gem.add_development_dependency "rspec"
end
