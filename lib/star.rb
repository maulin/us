class Star
  SIZE = 4

  attr_reader :pos

  def initialize(pos, color)
    @pos = pos
    @color = color
  end

  def draw
    nw = Point.new(pos.x - SIZE, pos.y - SIZE)
    sw = Point.new(pos.x - SIZE, pos.y + SIZE)
    ne = Point.new(pos.x + SIZE, pos.y - SIZE)
    se = Point.new(pos.x + SIZE, pos.y + SIZE)

    G.draw_quad(nw, ne, sw, se, @color)
  end

  def to_s
    pos.to_s
  end

  def width
    SIZE * 2
  end

  def height
    SIZE * 2
  end
end
