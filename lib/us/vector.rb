module Us
  class Vector
    attr_reader :vec

    def initialize(p1, p2)
      x = p2.x - p1.x
      y = p2.y - p1.y

      @vec = Point.new(x, y)
    end

    def magnitude
      @magnitude ||= Math.sqrt(@vec.x**2 + @vec.y**2)
    end

    def heading
      @heading ||= Point.new(@vec.x / magnitude, @vec.y / magnitude)
    end
  end
end
