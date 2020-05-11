require_relative './point'
require_relative './g'

module Us
  class Camera
    ZOOM_MAX = 2
    ZOOM_MIN = 0.5
    ZOOM_NORM = 1
    ZOOM_INTERVAL = 0.2
    SPEED = 15

    attr_reader :pos, :zoom, :center

    def initialize
      @center = Point.new(G.window.width / 2, G.window.height / 2)
      @zoom = ZOOM_NORM
      @pos = Point.new(0, 0)
    end

    def reset
      @pos.x = 0
      @pos.y = 0
      @zoom = ZOOM_NORM
      @center.x = G.window.width / 2
      @center.y = G.window.height / 2
    end

    def move_left
      @pos.x += SPEED
      @center.x -= SPEED
    end

    def move_right
      @pos.x -= SPEED
      @center.x += SPEED
    end

    def move_up
      @pos.y += SPEED
      @center.y -= SPEED
    end

    def move_down
      @pos.y -= SPEED
      @center.y += SPEED
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
      "CAM: #{pos} - #{zoom} - #{center}"
    end
  end
end
