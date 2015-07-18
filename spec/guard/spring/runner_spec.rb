require 'spec_helper'

describe Guard::Spring::Runner do
  let(:options) { {} }
  let(:runner) { described_class.new options }

  before do
    allow(runner).to receive(:system).and_raise(NotImplementedError)
  end

  describe '#initialize' do
    it 'has default options and allow overrides' do
      expect(runner.options).to eq(options)
    end
  end

  describe '#start' do
    it 'outputs a message' do
      expect(::Guard::UI).to receive(:info).with(/starting/i)
      allow(runner).to receive(:start_spring)
      runner.start
    end

    it 'calls start_spring' do
      expect(runner).to receive(:start_spring).with(no_args)
      runner.start
    end
  end

  describe '#stop' do
    it 'outputs a message' do
      expect(::Guard::UI).to receive(:info).with(/stopping/i)
      allow(runner).to receive(:stop_spring)
      runner.stop
    end

    it 'calls stop_spring' do
      expect(runner).to receive(:stop_spring).with(no_args)
      runner.stop
    end
  end

  describe '#restart' do
    it 'outputs a message' do
      expect(::Guard::UI).to receive(:info).with(/restarting/i)
      allow(runner).to receive(:stop_spring)
      allow(runner).to receive(:start_spring)
      runner.restart
    end

    it 'calls stop_spring and start_spring' do
      expect(runner).to receive(:stop_spring).with(no_args).ordered
      expect(runner).to receive(:start_spring).with(no_args).ordered
      runner.restart
    end
  end

  describe '#spring_command' do
    let(:bin_stub_exists) { false }
    let(:bin_stub_path) { 'foo' }
    subject { runner.send(:spring_command) }
    before do
      allow(runner).to receive(:bin_stub_exists?).and_return(bin_stub_exists)
      allow(runner).to receive(:bin_stub).and_return(bin_stub_path)
    end

    context 'when cmd option is present' do
      let(:options) { {cmd: 'foobar'} }
      it { is_expected.to eq('foobar') }
    end

    context 'when cmd option is unused' do
      context 'with bundler: true' do
        let(:options) { {bundler: true} }

        context 'when bin stub exists' do
          let(:bin_stub_exists) { true }
          it { is_expected.to eq('bundle exec spring') }
        end

        context 'when bin stub does not exist' do
          let(:bin_stub_exists) { false }
          it { is_expected.to eq('bundle exec spring') }
        end
      end
      context 'with bundler: false' do
        let(:options) { {bundler: false} }

        context 'when bin stub exists' do
          let(:bin_stub_exists) { true }
          it { is_expected.to eq(bin_stub_path) }
        end

        context 'when bin stub does not exist' do
          let(:bin_stub_exists) { false }
          it { is_expected.to eq('spring') }
        end
      end
    end
  end

  describe '#bin_stub' do
    subject { runner.send(:bin_stub) }
    it { is_expected.to eq('./bin/spring') }
  end

  describe '#bin_stub_exists?' do
    let(:bin_stub_path) { 'foo' }

    it 'checks whether the bin_stub exists' do
      allow(runner).to receive(:bin_stub).and_return(bin_stub_path)
      expect(File).to receive(:exist?).with(bin_stub_path).and_return(0xdeadbeef)
      expect(runner.send(:bin_stub_exists?)).to eq(0xdeadbeef)
    end
  end

  describe '#start_spring' do
    it 'makes a system call to start Spring' do
      allow(runner).to receive(:environments).and_return(%w(env1 env2))
      allow(runner).to receive(:spring_command).and_return('barbaz')
      expect(runner).to receive(:system).with(/barbaz rake -T RAILS_ENV='env1'/).and_return(true)
      expect(runner).to receive(:system).with(/barbaz rake -T RAILS_ENV='env2'/).and_return(true)
      runner.send(:start_spring)
    end
  end

  describe '#stop_spring' do
    it 'makes a system call to stop Spring' do
      allow(runner).to receive(:spring_command).and_return('spring')
      expect(runner).to receive(:system).with(/spring stop/).and_return(true)
      runner.send(:stop_spring)
    end
  end
end
