module Us
  class Vector
    def initialize(p1, p2)
      x = p2.x - p1.x
      y = p2.y - p1.y

      @vec = Point.new(x, y)
    end

    def x
      @vec.x
    end

    def y
      @vec.y
    end

    def magnitude
      @magnitude ||= Math.sqrt(@vec.x**2 + @vec.y**2)
    end

    def heading
      @heading ||= Point.new(@vec.x / magnitude, @vec.y / magnitude)
    end
  end
end
