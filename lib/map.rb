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

    generate_grid
    @stars = initialize_stars
    build_carrier
  end

  def generate_grid
    @grid = []
    rows = @height / LY
    cols = @width / LY

    rows.times do |i|
      @grid << []
      y = i * LY

      cols.times do |j|
        x = j * LY

        nw = Point.new(x, y)
        ne = Point.new(x + LY, y)
        se = Point.new(x + LY, y + LY)
        sw = Point.new(x, y + LY)
        center = Point.new(x + HLY, y + HLY)

        quad = Quad.new(nw, ne, se, sw, center)
        @grid[i] << quad
      end
    end
  end

  def initialize_stars
    star_1_quad = @grid[40][50]
    star_2_quad = @grid[40][100]

    stars = []
    stars << Star.new(star_1_quad)
    stars << Star.new(star_2_quad)
  end

  def build_carrier
    quad = @grid[20][100]
    @carrier = Carrier.new(quad)
    @carrier.travel(@stars.sample.center)
  end
  
  def move_objects
    @carrier.move
  end

  def draw_stars
    @stars.each do |s|
      G.draw_quad(
        s.nw.x, s.nw.y, Gosu::Color::BLUE,
        s.ne.x, s.ne.y, Gosu::Color::BLUE,
        s.sw.x, s.sw.y, Gosu::Color::BLUE,
        s.se.x, s.se.y, Gosu::Color::BLUE
      )
    end
  end

  def draw_carriers
    @carrier.draw
  end

  def draw_grid
    (@width / LY).times do |i|
      x = i * LY
      G.draw_line(x, 0, GRID_COLOR, x, @height, GRID_COLOR)
    end

    (@height / LY).times do |i|
      y = i * LY
      G.draw_line(0, y, GRID_COLOR, @width, y, GRID_COLOR)
    end
  end

  def draw
    draw_grid
    draw_stars
    draw_carriers
  end
end
