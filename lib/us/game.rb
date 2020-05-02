module Us
  class Game
    attr_accessor :state

    def initialize(game_data)
      @ring = Gosu::Image.new(File.expand_path("./assets/pring_orange.png"))
      @star = Gosu::Image.new(File.expand_path("./assets/visible_star.png"))
      @stars = game_data["stars"]
    end

    def draw
      @stars.each do |s|
        @ring.draw(s["x"], s["y"], 10)
        @star.draw(s["x"], s["y"], 10)
      end
    end
  end
end
