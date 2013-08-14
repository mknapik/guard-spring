# Guard::Spring

Guard::Spring automatically runs RSpec with [Spring](https://github.com/jonleighton/spring).

Read more about [Spring](https://github.com/jonleighton/spring) - Rails application preloader.

Learn how to monitor file system changes with [Guard](https://github.com/guard/guard).

It seems that [guard-rspec](https://github.com/guard/guard-rspec) supports *Spring* now.

## Installation

Add this line to your application's Gemfile:

    gem 'guard-spring'

And then execute:

    $ bundle

## Usage

Add rules to Guardfile:

    $ guard init spring

Run guard. Press Enter to run all specs.

    $ guard

After any modification of project file or spec should run RSpec with Spring.

You can modify the Guardfile to create your own rules and dependencies to run specs.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
