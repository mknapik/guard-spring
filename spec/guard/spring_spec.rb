require 'spec_helper'

describe Guard::Spring do
  describe '#initialize' do
    it 'instantiates Runner with given options' do
      expect(described_class::Runner).to receive(:new).with(foo: 'bar')
      described_class.new(foo: 'bar')
    end
  end

  context 'with a plugin instance' do
    let(:options) { {} }
    let(:plugin_instance) { described_class.new(options) }
    let(:runner) { double(described_class::Runner) }
    before do
      allow(plugin_instance).to receive(:runner).and_return(runner)
    end

    describe '#start' do
      it 'call runner.start' do
        expect(runner).to receive(:start).with(no_args)
        plugin_instance.start
      end
    end

    describe '#stop' do
      it 'call runner.stop' do
        expect(runner).to receive(:stop).with(no_args)
        plugin_instance.stop
      end
    end

    describe '#reload' do
      it 'calls runner.restart' do
        expect(runner).to receive(:restart).with(no_args)
        plugin_instance.reload
      end
    end

    describe '#run_all' do
      it 'does nothing' do
        plugin_instance.run_all
      end
    end

    describe '#run_on_changes' do
      it 'calls runner.restart' do
        expect(runner).to receive(:restart).with(no_args)
        plugin_instance.run_on_changes('foo')
      end
    end

    describe '#run_on_removals' do
      it 'calls runner.restart' do
        expect(runner).to receive(:restart).with(no_args)
        plugin_instance.run_on_removals('foo')
      end
    end
  end
end
