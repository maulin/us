require_relative './point'
require_relative './quad'
require_relative './star'
require_relative './carrier'

class Map
  LY = 20
  HLY = 10
  GRID_COLOR = Gosu::Color.argb(255, 128, 128, 128)

  def initialize(width, height)
    @width = width
    @height = height

    @stars = init_stars
  end

  def init_stars
    stars = []

    colors = [:red, :yellow, :green, :blue, :fuchsia, :white]

    Game::START_STARS.times do
      color = colors.pop

      if stars.empty?
        x = rand(Star::SIZE..(@width - Star::SIZE))
        y = rand(Star::SIZE..(@height - Star::SIZE))
        star = Star.new(Point.new(x, y), color)
        pp "initial star: #{star}"
        stars << star
      else
        star = stars.sample

        distance = rand(Game::STAR_MIN_DISTANCE..Game::START_STARS_MAX_DISTANCE)
        angle = rand(0..360)
        x = star.center.x + (distance * Math.sin(Math::PI/180 * angle))
        y = star.center.y - (distance * Math.cos(Math::PI/180 * angle))
        new_star = Star.new(Point.new(x, y), color)

        pp "start star: #{star}, new star: #{new_star}, angle: #{angle}, distance: #{distance}"

        stars << new_star
      end
    end

    stars
  end

  def draw_stars
    @stars.each(&:draw)
  end

  def draw_carriers
    @carrier.draw
  end

  def draw
    draw_stars
  end
end
