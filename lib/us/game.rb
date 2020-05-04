require_relative 'player'
module Us
  class Game
    attr_accessor :players

    def initialize(game_data, state)
      @state = state
      @ring = Gosu::Image.new(File.expand_path("./assets/orange.png"))
      @star = Gosu::Image.new(File.expand_path("./assets/visible_star.png"))
      @hud = Menu::Hud.new(self)
      @ticks = -1

      update_objects(game_data)
    end

    def draw
      @hud.draw
      @stars.each do |s|
        @ring.draw(s["x"], s["y"], 10)
        @star.draw(s["x"], s["y"], 10)
      end
    end

    def update_objects(game_data)
      return if game_data["clock"]["ticks"] <= @ticks

      @stars = game_data["stars"]
      @ticks = game_data["clock"]["ticks"]
      @tick_start_time = game_data["clock"]["tick_start_time"]
      @cycle_counter = game_data["clock"]["cycle_counter"]

      @players = game_data["players"].map { |p| Player.new(id: p["id"], name: p["name"], color: p["color"]) }
      @last_update = Time.now.utc.to_i
    end

    def clock
      "Production: #{Us::Server::Clock::CYCLE_COUNTER - (Time.now.utc.to_i - @tick_start_time)}s"
    end

    def update
      current_time = Time.now.utc.to_i
      return unless current_time - @last_update > 1

      if Time.now.utc.to_i - @tick_start_time > Us::Server::Clock::CYCLE_COUNTER
        @state.update_game
      end
    end
  end
end
