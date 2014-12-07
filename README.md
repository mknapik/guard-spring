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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
