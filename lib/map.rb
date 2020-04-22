require_relative './point'
require_relative './quad'
require_relative './star'
require_relative './carrier'

class Map
  LY = 20
  HLY = 10
  GRID_COLOR = Gosu::Color.argb(255, 128, 128, 128)

  def initialize(width, height)
    @width = 1024
    @height = 768
    @stars = []

    gen_grid
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

  def gen_grid
    # @grid = {}
    # (0..@width).step(50) do |x|
      # @grid[x] = {}
      # (0..@height).step(50) do |y|
        # image = Gosu::Image.from_text(G.window, "#{x}:#{y}", Gosu.default_font_name, 12)
        # @grid[x][y] = image
      # end
    # end
  end

  def draw_g(camera)
    i1 = Gosu::Image.from_text(G.window, "***This is image one***", Gosu.default_font_name, 15)
    i2 = Gosu::Image.from_text(G.window, "***This is image two ***", Gosu.default_font_name, 15)

    i1.draw(-20, 100, 0) if camera.can_view?(-20, 100, i1)
    i2.draw(700, 500, 0) if camera.can_view?(700, 500, i2)
    # @grid.each do |x, row|
      # row.each do |y, val|
        # val.draw(x, y, 0) if camera.can_view?(x, y, val)
      # end
    # end
  end

  def draw(camera)
    draw_g(camera)
    # draw_grid
    # draw_stars
    # draw_carriers
  end
end
