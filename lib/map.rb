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

    # generate_grid
    # @stars = initialize_stars
    # build_carrier
    gen_grid
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
    @carrier.travel(@stars.sample.quad)
  end
  
  def move_objects
    # @carrier.move
  end

  def draw_stars
    @stars.each do |s|
      G.draw_quad(s.nw, s.ne, s.sw, s.se, :blue)
    end
  end

  def draw_carriers
    @carrier.draw
  end

  def draw_grid
    (@width / LY).times do |i|
      x = i * LY
      G.draw_line(Point.new(x, 0), Point.new(x, @height), :white)
    end

    (@height / LY).times do |i|
      y = i * LY
      G.draw_line(Point.new(0, y), Point.new(@width, y), :white)
    end
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
