require_relative '../point'
require_relative './star'

module Us
  module Server
    class Map
      WIDTH = 2560
      HEIGHT = 1440
      LY = 75

      attr_reader :stars

      def initialize
        @width = WIDTH
        @height = HEIGHT
      end

      def init_stars_for(player:)
        stars = []

        Game::START_STARS.times do |i|
          if stars.empty?
            x = rand(LY..(@width - LY))
            y = rand(LY..(@height - LY))
            star = Star.new(pos: Point.new(x, y), owner: player)

            stars << star
            Server.game.stars << star
          else
            star = stars.sample
            new_star_location = star_location_near(star)

            until star_location_valid?(new_star_location) do
              new_star_location = star_location_near(star)
            end

            new_star = Star.new(pos: new_star_location, owner: player)

            stars << new_star
            Server.game.stars << new_star
          end
        end
      end

      def star_location_near(star)
        distance = rand(LY..Game::START_STARS_MAX_DISTANCE)
        angle = rand(0..360)
        x = star.pos.x + Gosu.offset_x(angle, distance)
        y = star.pos.y - Gosu.offset_y(angle, distance)

        Point.new(x, y)
      end

      def star_location_valid?(location)
        Server.game.stars.all? do |s|
          magnitude = Vector.new(s.pos, location).magnitude
          magnitude >= LY
        end
      end
    end
  end
end
