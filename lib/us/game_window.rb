require_relative './camera'
require_relative './game'
require_relative './quad'
require_relative './menu/game'
require_relative './menu/user'

module Us
  class GameWindow < Gosu::Window
    def initialize
      super(WIDTH, HEIGHT)
      self.caption = "Uranus's Shame"
      @camera = Camera.new(WIDTH, HEIGHT)
      @user_menu = Us::Menu::User.new(self)
      @game_menu = Us::Menu::Game.new
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
        interactor.handle_click(pos)
      when Gosu::KbReturn
        interactor.handle_return
      end
    end

    def update
      interactor.update if interactor.is_a?(Game)
      @camera.move_left if button_down?(Gosu::KbA)
      @camera.move_right if button_down?(Gosu::KbD)
      @camera.move_up if button_down?(Gosu::KbW)
      @camera.move_down if button_down?(Gosu::KbS)
    end

    def interactor
      if Us.current_user
        Us.game ? Us.game : @game_menu
      else
        @user_menu
      end
    end

    def draw
      interactor.draw
    end
  end
end
