require_relative './point'

module Us
  class Camera
    ZOOM_MAX = 2
    ZOOM_MIN = 1
    ZOOM_INTERVAL = 0.2
    SPEED = 15

    attr_reader :pos, :zoom

    def initialize(width, height)
      @zoom = ZOOM_MIN
      @pos = Point.new(0, 0)
      @width = width
      @height = height
    end

    def reset
      @pos.x = 0
      @pos.y = 0
      @zoom = ZOOM_MIN
    end

    def move_left
      @pos.x += SPEED
    end

    def move_right
      @pos.x -= SPEED
    end

    def move_up
      @pos.y += SPEED
    end

    def move_down
      @pos.y -= SPEED
    end

    def zoom_in
      return if @zoom >= ZOOM_MAX

      @zoom += ZOOM_INTERVAL
    end

    def zoom_out
      return if @zoom <= ZOOM_MIN

      @zoom -= ZOOM_INTERVAL
    end

    def to_s
      "CAM: #{@pos} - #{@zoom}"
    end
  end
end
