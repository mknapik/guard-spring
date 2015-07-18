# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
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
  gem.license       = 'MIT'

  gem.files         = Dir.glob('{lib}/**/*') + %w[LICENSE.txt README.md]
  gem.test_files    = Dir.glob('{spec}/**/*')
  gem.require_path  = 'lib'

  gem.add_dependency 'guard', '~> 2.0'
  gem.add_dependency 'guard-compat', '~> 1.1'
  gem.add_dependency 'spring'

  gem.add_development_dependency 'bundler', '~> 1.7'
  gem.add_development_dependency 'rake', '~> 10.0'

  gem.add_development_dependency 'rubocop', '~> 0.31'
  gem.add_development_dependency 'rubocop-rspec', '~> 1.3'

  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'codeclimate-test-reporter'
end
