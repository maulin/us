require_relative './vector'

class Carrier
  def initialize(quad)
    @position = quad.center
  end

  def travel(quad)
    @dest = quad
    @dest_vec = Vector.new(@position, @dest.center)
  end

  def move
    return unless @dest

    @position.x += (@dest_vec.heading.x * Map::LY)
    @position.y += (@dest_vec.heading.y * Map::LY)

    if @dest.contains?(@position)
      @position = @dest.center
      @dest = nil
    end
  end

  def draw
    c = @position
    p1 = Point.new(c.x, c.y - Map::HLY)
    p2 = Point.new(c.x - Map::HLY, c.y + Map::HLY)
    p3 = Point.new(c.x + Map::HLY, c.y + Map::HLY)

    G.draw_triangle(p1, p2, p3, :white)
  end
end
