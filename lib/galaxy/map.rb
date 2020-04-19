module Galaxy
  class Map
    def initialize(width, height)
      @width = width
      @height = height

      generate_grid
    end

    def generate_grid
      @grid = []
      rows = @height / QUAD_LENGTH
      cols = @width / QUAD_LENGTH

      rows.times do |i|
        @grid << []
        y = i * QUAD_LENGTH

        cols.times do |j|
          x = j * QUAD_LENGTH

          nw = Point.new(x, y)
          ne = Point.new(x + QUAD_LENGTH, y)
          se = Point.new(x + QUAD_LENGTH, y + QUAD_LENGTH)
          sw = Point.new(x, y + QUAD_LENGTH)
          center = Point.new(x + QUAD_LENGTH / 2, y + QUAD_LENGTH / 2)

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
  end
end
