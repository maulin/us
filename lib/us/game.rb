module Us
  class Game
    attr_accessor :state

    def initialize(game_data, state)
      @state = state
      @ring = Gosu::Image.new(File.expand_path("./assets/pring_orange.png"))
      @star = Gosu::Image.new(File.expand_path("./assets/visible_star.png"))
      @stars = game_data["stars"]
      @ticks = game_data["clock"]["ticks"]
      @tick_start_time = game_data["clock"]["tick_start_time"]
      @cycle_counter = game_data["clock"]["cycle_counter"]
      @hud = Menu::Hud.new(self)
    end

    def draw
      @hud.draw
      @stars.each do |s|
        @ring.draw(s["x"], s["y"], 10)
        @star.draw(s["x"], s["y"], 10)
      end
    end

    def update_objects(game_data)
      if game_data["clock"]["ticks"] <= @ticks
      else
        @stars = game_data["stars"]
        @ticks = game_data["clock"]["ticks"]
        @tick_start_time = game_data["clock"]["tick_start_time"]
        @cycle_counter = game_data["clock"]["cycle_counter"]
      end
    end

    def clock
      "CLOCK: TICKS - #{@ticks}"
    end

    def update
      return if @state.state == :updating

      if Time.now.utc.to_i - @tick_start_time >= @cycle_counter
        puts "FETCHING UPDATE"
        @state.update_game
      end
    end
  end
end
