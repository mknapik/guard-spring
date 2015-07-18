[![Build Status](https://travis-ci.org/mknapik/guard-spring.svg?branch=master)](https://travis-ci.org/mknapik/guard-spring)
[![Dependency Status](https://gemnasium.com/mknapik/guard-spring.svg)](https://gemnasium.com/mknapik/guard-spring)
[![Code Climate](https://codeclimate.com/github/mknapik/guard-spring/badges/gpa.svg)](https://codeclimate.com/github/mknapik/guard-spring)
[![Test Coverage](https://codeclimate.com/github/mknapik/guard-spring/badges/coverage.svg)](https://codeclimate.com/github/mknapik/guard-spring/coverage)
[![Gem Version](https://badge.fury.io/rb/guard-spring.svg)](http://badge.fury.io/rb/guard-spring)

# Guard::Spring

Guard::Spring starts, stops, and restarts [Spring](https://github.com/jonleighton/spring) - Rails application preloader. This plugin therefore most importantly ensures that Spring is not left running when Guard is stopped.

Learn how to monitor file system changes with [Guard](https://github.com/guard/guard).

It seems that [guard-rspec](https://github.com/guard/guard-rspec) can support *Spring* now, using the `cmd` option. This plugin is used to manage Spring itself, not to inject Spring into the running of Rspec.

## Installation

Add this line to your application's Gemfile:

    gem 'guard-spring'

And then execute:

    $ bundle

## Usage

Add rules to Guardfile:

    $ bundle exec guard init spring

Run guard. Press Enter to run all specs.

    $ bundle exec guard

After any modification of monitored files Spring will be restarted.

## Options

### List of available options:

Default values shown here.

    cmd: 'spring'                      # Specify a custom Spring command to run, default: 
                                       # 'bundle exec spring' if bundler option is enabled,
                                       # 'bin/spring' if it exists, or 'spring'.
    bundler: false                     # If true, use 'bundle exec' to run Spring
                                       # (cmd option overrides this).
    environments: %w(test development) # Which environments to start when Guard starts.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
