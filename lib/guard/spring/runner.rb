require 'spring/commands'

module Guard
  class Spring
    class Runner
      attr_reader :options

      def initialize(options = {})
        @options = options
        UI.info 'Guard::Spring Initialized'
      end

      def launch_spring(action)
        UI.info "#{action}ing Spring", :reset => true
        start_spring
      end

      def kill_spring
        stop_spring
      end

      def run(paths)
        existing_paths = paths.select { |path| File.exist? "#{Dir.pwd}/#{path}" }
        rspec_paths = existing_paths.select { |path| path =~ /spec(\/\w+)*(\/\w+_spec\.rb)?/ }
        run_command 'spring rspec', existing_paths.join(' ') unless rspec_paths.empty?

        # TBD: # testunit_paths = existing_paths.select { |path| path =~ /spec\/.+_spec\.rb/ }
        # TBD: # run_command 'spring testunit', existing_paths.join(' ') unless testunit_paths.empty?
      end

      def run_all
        if rspec?
          run(%w(spec))
        elsif test_unit?
          run(Dir['test/**/*_test.rb']+Dir['test/**/test_*.rb'])
        end
      end

      private

      def run_command(cmd, options = '')
        puts "#{cmd} #{options}"
        system "#{cmd} #{options}"
      end

      def fork_exec(cmd, options = '')
        fork do
          exec "#{cmd} #{options}"
        end
      end

      def start_spring
        fork_exec('spring start > /dev/null')
        UI.info 'Starting Spring ', :reset => true
      end

      def stop_spring
        run_command('spring stop')
        UI.info 'Stopping Spring ', :reset => true
      end

      def push_command(paths)
        cmd_parts = []
        cmd_parts << 'spring rspec'
        cmd_parts << paths.join(' ')
        cmd_parts.join(' ')
      end

      def bundler?
        @bundler ||= options[:bundler] != false && File.exist?("#{Dir.pwd}/Gemfile")
      end

      def test_unit?
        @test_unit ||= options[:test_unit] != false && File.exist?("#{Dir.pwd}/test/test_helper.rb")
      end

      def rspec?
        @rspec ||= options[:rspec] != false && File.exist?("#{Dir.pwd}/spec")
      end
    end
  end
end
