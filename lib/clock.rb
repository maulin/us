class Clock
  TICK_INTERVAL = 1

  def initialize
    @start_time = @last_tick_time = current_time
    @tick = 0
  end

  def draw
    time = "#{Time.now.strftime("%I:%M:%S %p")} - Tick: #{@tick}"
    G.draw_text(time, 10, 10)
  end

  def current_time
    Time.now.to_i
  end

  def tick?
    if current_time - @last_tick_time >= TICK_INTERVAL
      @last_tick_time = current_time
      @tick += 1
      return true
    end
    false
  end
end
