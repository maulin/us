require_relative './vector'

class Carrier
  def initialize(name, pos)
    @name = name
    @pos = pos
  end

  def travel(quad)
    @dest = quad
    @dest_vec = Vector.new(@pos, @dest.center)
  end

  def move
    return unless @dest

    @pos.x += (@dest_vec.heading.x * Map::LY)
    @pos.y += (@dest_vec.heading.y * Map::LY)

    if @dest.contains?(@pos)
      @pos = @dest.center
      @dest = nil
    end
  end

  def draw
    p1 = Point.new(@pos.x, @pos.y - Star::SIZE)
    p2 = Point.new(@pos.x - Star::SIZE, @pos.y + Star::SIZE)
    p3 = Point.new(@pos.x + Star::SIZE, @pos.y + Star::SIZE)

    G.draw_triangle(p1, p2, p3, :white)
  end
end
