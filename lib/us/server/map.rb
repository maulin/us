require_relative '../point'
require_relative './star'
require_relative './carrier'

module Us
  module Server
    class Map
      WIDTH = 2560
      HEIGHT = 1440

      attr_reader :stars

      def initialize
        @width = WIDTH
        @height = HEIGHT
        @stars = []
        @carriers = []
      end

      def init_stars_for(player:)
        stars = []

        Game::START_STARS.times do |i|
          if stars.empty?
            x = rand(Star::SIZE..(@width - Star::SIZE))
            y = rand(Star::SIZE..(@height - Star::SIZE))
            star = Star.new(
              pos: Point.new(x, y), color: player.color, name: i,
              owner: player
            )

            stars << star
            @stars << star
          else
            star = stars.sample
            new_star_location = star_location_near(star)

            until star_location_valid?(new_star_location) do
              new_star_location = star_location_near(star)
            end

            new_star = Star.new(
              pos: new_star_location, color: player.color, name: i,
              owner: player
            )

            stars << new_star
            @stars << new_star
          end
        end
      end

      def star_location_near(star)
        distance = rand((Star::SIZE * 2)..Game::START_STARS_MAX_DISTANCE)
        angle = rand(0..360)
        x = star.pos.x + (distance * Math.sin(Math::PI/180 * angle))
        y = star.pos.y - (distance * Math.cos(Math::PI/180 * angle))

        Point.new(x, y)
      end

      def star_location_valid?(location)
        @stars.all? do |s|
          magnitude = Vector.new(s.pos, location).magnitude
          magnitude > s.width
        end
      end

      def create_carrier_at(star)
        name = "#{star.name} - #{@carriers.count + 1}"
        @carriers << Carrier.new(name, star.pos)
      end
    end
  end
end
