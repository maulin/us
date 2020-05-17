module Us
  module Server
    class Clock
      TICK_INTERVAL = 20
      CYCLE_TICKS = 4

      attr_reader :ticks, :tick_start_time

      def initialize
        @ticks = 0
        @cycles = 0
        @tick_start_time = 0
        @tick_interval = TICK_INTERVAL
      end

      def start
        @start_time = current_time
        @tick_start_time = current_time
      end

      def current_time
        Time.now.utc.to_i
      end

      def tick
        @tick_interval -= 1
        puts self
        sleep 1
      end

      def tick_complete?
        @tick_interval == 0
      end

      def cycle_complete?
        @ticks % CYCLE_TICKS == 0
      end

      def increment_tick
        @ticks += 1
        @tick_start_time = current_time
        @tick_interval = TICK_INTERVAL
      end

      def increment_cycle
        @cycles += 1
      end

      def to_s
        "CLOCK: #{@cycles} - #{@ticks}"
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
