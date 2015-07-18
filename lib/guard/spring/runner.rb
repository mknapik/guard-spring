require 'spring/commands'

module Guard
  class Spring
    class Runner
      attr_reader :options
      attr_writer :spring_command

      def initialize(options = {})
        @options = options
      end

      def start
        UI.info 'Guard::Spring starting Spring'
        start_spring
      end

      def stop
        UI.info 'Guard::Spring stopping Spring'
        stop_spring
      end

      def restart
        UI.info 'Guard::Spring restarting Spring'
        stop_spring
        start_spring
      end

      private

      def start_spring
        environments.each do |env|
          system "#{spring_command} rake -T RAILS_ENV='#{env}' > /dev/null"
        end
      end

      def stop_spring
        system "#{spring_command} stop"
      end

      def spring_command
        @spring_command ||= begin
          if options[:cmd]
            options[:cmd]
          elsif bundler?
            'bundle exec spring'
          elsif bin_stub_exists?
            bin_stub
          else
            'spring'
          end
        end
      end

      def bin_stub
        './bin/spring'
      end

      def bin_stub_exists?
        File.exist? bin_stub
      end

      def bundler?
        options.fetch(:bundler, false)
      end

      def environments
        options.fetch(:environments, %w(test development))
      end
    end
  end
end
