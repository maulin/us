require_relative '../quad'
require_relative '../point'
require_relative '../game_window'

module Us
  module Menu
    class Hud
      HEIGHT = 100
      WIDTH = Us::GameWindow::WIDTH * 0.20

      def initialize(game)
        @game = game
      end

      def draw
        text = @game.clock
        G.draw_text(
          text: text, pos: Point.new(10, 10), z: 100, size: :medium
        )
      end

      def handle_click
      end
    end
  end
end
