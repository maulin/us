class Camera
  attr_reader :nw

  def initialize(width, height)
    @zoom = 1
    @nw = Point.new(0, 0)
    @width = width
    @height = height
  end

  def move_left
    @nw = Point.new(@nw.x - 10, @nw.y)
  end

  def move_right
    @nw = Point.new(@nw.x + 10, @nw.y)
  end

  def can_view?(x, y, obj)
    ((@nw.x - obj.width)..@width).include?(x) &&
    ((@nw.y - obj.height)..@height).include?(y)
  end
end
