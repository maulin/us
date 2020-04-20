class Carrier
  def initialize(quad)
    @quad = quad
    @position = quad.center
    pp "carrier pos", @position
  end

  def travel(point)
    @dest = point
    dest_vec = [@dest.x - @position.x, @dest.y - @position.y]
    magnitude = Math.sqrt(dest_vec[0]**2 + dest_vec[1]**2)
    @heading = [dest_vec[0]/magnitude, dest_vec[1]/magnitude]
  end

  def move
    puts "MOVING"
    pp @heading
    pp @dest

    if @position.x != @dest.x || @position.y != @dest.y
      distance = Map::LY
      @position.x += (@heading[0] * distance)
      @position.y += (@heading[1] * distance)
      pp @position
    end
  end

  def draw
    c = @position
    p1 = Point.new(c.x, c.y - Map::HLY)
    p2 = Point.new(c.x - Map::HLY, c.y + Map::HLY)
    p3 = Point.new(c.x + Map::HLY, c.y + Map::HLY)
    G.draw_triangle(
      p1.x, p1.y, Gosu::Color::WHITE,
      p2.x, p2.y, Gosu::Color::WHITE,
      p3.x, p3.y, Gosu::Color::WHITE
		)
  end
end
