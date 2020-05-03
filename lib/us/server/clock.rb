module Us
  module Server
    class Clock
      TICK_INTERVAL = 5
      CYCLE_TICKS = 2
      CYCLE_COUNTER = TICK_INTERVAL * CYCLE_TICKS

      attr_reader :ticks, :tick_start_time, :cycle_counter

      def initialize
        @start_time = current_time
        @ticks = 0
        @tick_start_time = current_time
        @cycle_counter = CYCLE_COUNTER
      end

      def draw
        time = "#{Time.now.strftime("%I:%M:%S %p")} - Tick: #{@tick}"
        G.draw_text(text: time, pos: @clock_pos, z: 100, size: :medium)
      end

      def current_time
        Time.now.utc.to_i
      end

      def tick
        @cycle_counter -= 1
        puts self
        sleep 1
      end

      def produce?
        @cycle_counter == 0
      end

      def increment
        @ticks += 1
        @tick_start_time = current_time
        @cycle_counter = CYCLE_COUNTER
      end

      def to_s
        "CLOCK: #{@ticks} - #{@cycle_counter}"
      end
    end
  end
end
