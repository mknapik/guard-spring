require 'spring/commands'

module Guard
  class Spring
    class Runner
      attr_reader :options

      def initialize(options = {})
        @options = options
        @options[:rspec_cli] = options[:rspec_cli].nil? ? '' : " #{options[:rspec_cli]} "
        @spring_cmd = get_spring_cmd
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
        existing_paths = paths.uniq.select { |path| File.exist? "#{Dir.pwd}/#{path}" }
        rspec_paths = existing_paths.select { |path| path =~ /spec(\/\w+)*(\/\w+_spec\.rb)?/ }
        run_command "#@spring_cmd rspec", "#{rspec_cli}#{existing_paths.join(' ')}" unless rspec_paths.empty?

        # TBD: # testunit_paths = existing_paths.select { |path| path =~ /test(.*\.rb)?/ }
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
        UI.debug "Command execution: #{cmd} #{options}"
        system "#{cmd} #{options}"
      end

      def fork_exec(cmd, options = '')
        fork do
          UI.debug "(Fork) Command execution: #{cmd} #{options}"
          exec "#{cmd} #{options}"
        end
      end

      def start_spring
        fork_exec("#@spring_cmd start > /dev/null")
      end

      def stop_spring
        run_command("#@spring_cmd stop")
        UI.info 'Stopping Spring ', :reset => true
      end

      def push_command(paths)
        cmd_parts = []
        cmd_parts << "#@spring_cmd rspec"
        cmd_parts << paths.join(' ')
        cmd_parts.join(' ')
      end

      def get_spring_cmd
        return './bin/spring' if create_bin_stubs %w(rspec)

        UI.warning('Failed to create all required binstubs')
        'spring'
      end

      # returns false if creation of any binstub failed
      def create_bin_stubs(stubs)
        results = stubs.map do |stub|
          run_command 'spring binstub', stub unless File.exist? "#{Dir.pwd}/bin/#{stub}"
        end
        !results.any? or results.all? { |result| result }
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

      def rspec_cli
        options[:rspec_cli]
      end
    end
  end
end
