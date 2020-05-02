require_relative './camera'
require_relative './quad'

module Us
  class GameWindow < Gosu::Window
    WIDTH = 2560
    HEIGHT = 1440

    def initialize
      super(WIDTH, HEIGHT)
      self.caption = "Uranus's Shame"
      @camera = Camera.new(WIDTH, HEIGHT)
    end

    def needs_cursor?
      true
    end

    def button_down(id)
      case id
      when Gosu::MsWheelDown
        @camera.zoom_in
      when Gosu::MsWheelUp
        @camera.zoom_out
      when Gosu::KbSpace
        @camera.reset
      when Gosu::MsLeft
        pos = Point.new(mouse_x, mouse_y)
        Us.game_state.handle_click(pos)
      end
    end

    def update
      @camera.move_left if button_down?(Gosu::KbA)
      @camera.move_right if button_down?(Gosu::KbD)
      @camera.move_up if button_down?(Gosu::KbW)
      @camera.move_down if button_down?(Gosu::KbS)
    end

    def draw
      Us.game_state.draw
    end
  end
end
