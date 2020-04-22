class Star
  SIZE = 3

  attr_reader :center

  def initialize(center, color)
    @center = center
    @color = color
  end

  def draw
    nw = Point.new(@center.x - SIZE, @center.y - SIZE)
    sw = Point.new(@center.x - SIZE, @center.y + SIZE)
    ne = Point.new(@center.x + SIZE, @center.y - SIZE)
    se = Point.new(@center.x + SIZE, @center.y + SIZE)

    G.draw_quad(nw, ne, sw, se, @color)
  end

  def to_s
    "#{@color} - #{center}"
  end
end
