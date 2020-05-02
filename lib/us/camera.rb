require_relative './point'

module Us
  class Camera
    ZOOM_MAX = 3
    ZOOM_MIN = 1
    ZOOM_INTERVAL = 0.5
    SPEED = 10

    attr_reader :pos, :zoom

    def initialize(width, height)
      @zoom = ZOOM_MIN
      @pos = Point.new(0, 0)
      @width = width
      @height = height
    end

    def reset
      @pos = Point.new(0, 0)
      @zoom = ZOOM_MIN
    end

    def move_left
      @pos = Point.new(@pos.x - SPEED, @pos.y)
    end

    def move_right
      @pos = Point.new(@pos.x + SPEED, @pos.y)
    end

    def move_up
      @pos = Point.new(@pos.x, @pos.y - SPEED)
    end

    def move_down
      @pos = Point.new(@pos.x, @pos.y + SPEED)
    end

    def zoom_in
      return if @zoom >= ZOOM_MAX

      @zoom += ZOOM_INTERVAL
    end

    def zoom_out
      return if @zoom <= ZOOM_MIN

      @zoom -= ZOOM_INTERVAL
    end
  end
end
