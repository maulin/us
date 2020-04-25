class Clock
  TICK_INTERVAL = 5

  def initialize(window)
    @start_time = @last_tick_time = current_time
    @tick = 0
    @clock_pos = Point.new(window.width / 2, 10)
  end

  def draw
    time = "#{Time.now.strftime("%I:%M:%S %p")} - Tick: #{@tick}"
    G.draw_text(msg: time, pos: @clock_pos, z: 100, size: :medium)
  end

  def current_time
    Time.now.to_f
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
