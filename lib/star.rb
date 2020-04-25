require_relative './quad'

class Star
  SIZE = 6

  attr_reader :pos, :name

  def initialize(pos:, color:, name:)
    @pos = pos
    @color = color
    @name = name
  end

  def draw
    quad = Quad.new(
      Point.new(pos.x - SIZE, pos.y - SIZE),
      Point.new(pos.x + SIZE, pos.y - SIZE),
      Point.new(pos.x - SIZE, pos.y + SIZE),
      Point.new(pos.x + SIZE, pos.y + SIZE)
    )

    G.draw_quad(quad: quad, color: @color)
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

  def buy_carrier
    puts "buying carrier @ #{self}"
  end
end
