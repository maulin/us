class Star
  SIZE = 4

  attr_reader :pos

  def initialize(pos:, color:, name:)
    @pos = pos
    @color = color
    @name = name
  end

  def draw
    p1 = Point.new(pos.x - SIZE, pos.y - SIZE)
    p2 = Point.new(pos.x + SIZE, pos.y - SIZE)
    p3 = Point.new(pos.x - SIZE, pos.y + SIZE)
    p4 = Point.new(pos.x + SIZE, pos.y + SIZE)

    G.draw_quad(p1: p1, p2: p2, p3: p3, p4: p4, color: @color)
  end

  def to_s
    "STAR: #{@name}, POS: #{pos}"
  end

  def width
    SIZE * 2
  end

  def height
    SIZE * 2
  end
end
