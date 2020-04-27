require_relative './point'
require_relative './star'
require_relative './carrier'

class Map
  WIDTH = 2560
  HEIGHT = 1440

  def initialize
    @width = WIDTH
    @height = HEIGHT
    @stars = []
    @carriers = []

    init_stars
  end

  def init_stars
    stars = []

    Game::START_STARS.times do |i|
      if stars.empty?
        x = rand(Star::SIZE..(@width - Star::SIZE))
        y = rand(Star::SIZE..(@height - Star::SIZE))
        star = Star.new(pos: Point.new(x, y), color: :blue, name: i)

        stars << star
        @stars << star
      else
        star = stars.sample
        new_star_location = star_location_near(star)

        until star_location_valid?(new_star_location) do
          new_star_location = star_location_near(star)
        end

        new_star = Star.new(pos: new_star_location, color: :blue, name: i)

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

  def draw_stars
    @stars.each(&:draw)
  end

  def draw_carriers
    @carriers.each(&:draw)
  end

  def draw(camera)
    draw_stars
    draw_carriers
  end

  def object_clicked_at(pos)
    star = @stars.find do |s|
      magnitude = Vector.new(s.pos, pos).magnitude
      magnitude < Star::SIZE
    end
    star
  end

  def create_carrier_at(star)
    name = "#{star.name} - #{@carriers.count + 1}"
    @carriers << Carrier.new(name, star.pos)
  end
end
