require_relative '../quad'
require_relative '../point'
require_relative '../game_window'

module Us
  module Menu
    class Game
      HEIGHT = 400
      WIDTH = 800

      def initialize(state:)
        @state = state
        @quad = Quad.new(
          Point.new((GameWindow::WIDTH/2) - WIDTH/2, (GameWindow::HEIGHT/2) - HEIGHT/2),
          Point.new((GameWindow::WIDTH/2) + WIDTH/2, (GameWindow::HEIGHT/2) - HEIGHT/2),
          Point.new((GameWindow::WIDTH/2) - WIDTH/2, (GameWindow::HEIGHT/2) + HEIGHT/2),
          Point.new((GameWindow::WIDTH/2) + WIDTH/2, (GameWindow::HEIGHT/2) + HEIGHT/2),
        )

        offset = @quad.p1
        width = 400
        height = 100
        @create_button_quad = Quad.new(
          Point.new((WIDTH / 2 - width / 2) + offset.x, (HEIGHT / 2 - height / 2) + offset.y),
          Point.new((WIDTH / 2 + width / 2) + offset.x, (HEIGHT / 2 - height / 2) + offset.y),
          Point.new((WIDTH / 2 - width / 2) + offset.x, (HEIGHT / 2 + height / 2) + offset.y),
          Point.new((WIDTH / 2 + width / 2) + offset.x, (HEIGHT / 2 + height / 2) + offset.y),
        )
        @create_text_pos = Point.new(@create_button_quad.p1.x + 10, @create_button_quad.p1.y + 10)
      end

      def draw
        draw_background
      end

      def draw_background
        G.draw_quad(quad: @quad, color: :blue_dark, z: 10)
        G.draw_quad(quad: @create_button_quad, color: :blue_light, z: 20)
        G.draw_text(text: "Create Game", pos: @create_text_pos, z: 30, size: :medium)
      end

      def handle_click(pos)
        if @create_button_quad.contains?(pos)
          @state.create_game
        end
      end
    end
  end
end
