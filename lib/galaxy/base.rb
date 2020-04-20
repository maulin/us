module Galaxy
  class Base
    attr_accessor :stars, :map

    def initialize(width, height)
      @map = Map.new(width, height)
      @stars = @map.initialize_stars
    end

    def draw
      @stars.each do |s|
        G.draw_quad(
          s.nw.x, s.nw.y, Gosu::Color::BLUE,
          s.ne.x, s.ne.y, Gosu::Color::BLUE,
          s.sw.x, s.sw.y, Gosu::Color::BLUE,
          s.se.x, s.se.y, Gosu::Color::BLUE
        )
      end
    end
  end
end
