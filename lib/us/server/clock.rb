module Us
  module Server
    class Clock
      TICK_INTERVAL = 10
      PROD_TICKS = 2
      PROD_INTERVAL = TICK_INTERVAL * PROD_TICKS

      attr_reader :ticks, :tick_start_time

      def initialize
        @ticks = 0
        @tick_start_time = 0
        @prod_interval = PROD_INTERVAL
      end

      def start
        @start_time = current_time
        @tick_start_time = current_time
        puts "CLOCK START: #{@tick_start_time}"
      end

      def current_time
        Time.now.utc.to_i
      end

      def tick
        @prod_interval -= 1
        puts self
        sleep 1
      end

      def produce?
        @prod_interval == 0
      end

      def increment
        @ticks += 1
        @tick_start_time = current_time
        @prod_interval = PROD_INTERVAL
      end

      def to_s
        "CLOCK: #{@ticks} - #{@prod_interval}"
      end

      def client_resp
        {
          ticks: @ticks,
          tick_start_time: @tick_start_time
        }
      end
    end
  end
end
