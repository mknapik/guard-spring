# -*- encoding : utf-8 -*-
unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_group 'Guard::Spring', 'lib/guard'
    add_group 'Specs', 'spec'
  end
end

require 'rspec'
require 'guard/compat/test/helper'
require 'guard/spring'

ENV["GUARD_ENV"] = 'test'

RSpec.configure do |config|
  config.before(:each) do
    # Silence UI.info output
    allow(::Guard::UI).to receive(:info).and_return(true)
    allow(::Guard::Notifier).to receive(:notify).and_return(true)
  end
end
