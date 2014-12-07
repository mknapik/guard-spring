require 'spec_helper'

describe Guard::Spring do
  before do
    # Silence UI.info output
    allow(::Guard::UI).to receive(:info).and_return(true)
    allow(::Guard::Notifier).to receive(:notify).and_return(true)
  end

  describe '#initialize' do
    it "instantiates Runner with given options" do
      expect(Guard::Spring::Runner).to receive(:new).with(foo: 'bar')
      Guard::Spring.new(foo: 'bar')
    end
  end

  context 'with a plugin instance' do
    let(:options) { {} }
    let(:plugin_instance) { described_class.new(options) }
    before do
      allow_any_instance_of(described_class::Runner).to receive(:get_spring_cmd).and_return('spring')
    end

    describe '#start' do
      it "starts Runner" do
        expect(plugin_instance.runner).to receive(:kill_spring).ordered
        expect(plugin_instance.runner).to receive(:launch_spring).ordered
        plugin_instance.start
      end
    end

    describe '#run_all' do
      it "calls Runner.run" do
        expect(plugin_instance.runner).to receive(:run_all).with(no_args)
        plugin_instance.run_all
      end
    end

    describe '#run_on_changes' do
      it "calls Runner.run with file name" do
        expect(plugin_instance.runner).to receive(:run).with(['file_name.js'])
        plugin_instance.run_on_changes(['file_name.js'])
      end

      it "calls Runner.run with paths" do
        expect(plugin_instance.runner).to receive(:run).with(['spec/controllers', 'spec/requests'])
        plugin_instance.run_on_changes(['spec/controllers', 'spec/requests'])
      end
    end
  end
end
