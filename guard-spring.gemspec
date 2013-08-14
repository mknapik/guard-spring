# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/spring/version'

Gem::Specification.new do |gem|
  gem.name          = 'guard-spring'
  gem.version       = Guard::SpringVersion::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Michał Knapik']
  gem.email         = ['mknapik@student.agh.edu.pl']
  gem.description   = %q{Guard::Spring automatically runs tests with spring}
  gem.summary       = %q{Pushes watched files to spring}
  gem.homepage      = 'https://github.com/mknapik/guard-spring'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'guard'
  gem.add_dependency 'spring'
end
