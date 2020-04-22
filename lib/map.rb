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
    @stars = []

    init_stars
  end

  def init_stars
    stars = []

    Game::START_STARS.times do |i|
      if stars.empty?
        x = rand(Star::SIZE..(@width - Star::SIZE))
        y = rand(Star::SIZE..(@height - Star::SIZE))
        star = Star.new(Point.new(x, y), :blue)

        stars << star
        @stars << star
      else
        star = stars.sample
        new_star_location = star_location_near(star)

        until star_location_valid?(new_star_location) do
          new_star_location = star_location_near(star)
        end

        new_star = Star.new(new_star_location, :blue)

        stars << new_star
        @stars << new_star
      end
    end
  end

  def star_location_near(star)
    distance = rand((Star::SIZE * 2)..Game::START_STARS_MAX_DISTANCE)
    angle = rand(0..360)
    x = star.center.x + (distance * Math.sin(Math::PI/180 * angle))
    y = star.center.y - (distance * Math.cos(Math::PI/180 * angle))

    Point.new(x, y)
  end

  def star_location_valid?(location)
    @stars.all? do |s|
      magnitude = Vector.new(s.center, location).magnitude
      magnitude > Star::SIZE * 2
    end
  end

  def draw_stars
    @stars.each(&:draw)
  end

  def draw
    draw_stars
  end
end
