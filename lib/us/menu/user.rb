require_relative '../quad'
require_relative '../point'

module Us
  module Menu
    class User
      HEIGHT = 400
      WIDTH = 800

      def initialize(window)
        @quad = Quad.new(
          Point.new((Us::WIDTH/2) - WIDTH/2, (Us::HEIGHT/2) - HEIGHT/2),
          Point.new((Us::WIDTH/2) + WIDTH/2, (Us::HEIGHT/2) - HEIGHT/2),
          Point.new((Us::WIDTH/2) - WIDTH/2, (Us::HEIGHT/2) + HEIGHT/2),
          Point.new((Us::WIDTH/2) + WIDTH/2, (Us::HEIGHT/2) + HEIGHT/2),
        )

        @text_box_quad = Quad.new(
          Point.new(1000, 600), Point.new(1500, 600),
          Point.new(1000, 700), Point.new(1500, 700),
        )
        @font ||= Gosu::Font.new(45, name: 'Fira Mono')
        text_input = Gosu::TextInput.new
        window.text_input = text_input
      end

      def draw
        draw_background
        draw_input
      end

      def draw_input
        G.draw_rect(x: 1030, y: 650, w: 500, h: 100, color: :gray, z: 20)
        offset = G.window.text_input.text.size * 23
        @font.draw_text('Enter your name', 1030, 600, 30)
        @font.draw_text(G.window.text_input.text, 1030, 680, 30)
        G.draw_rect(x: 1030 + offset, y: 650, w: 10, h: 100, color: :white, z: 30)
      end

      def draw_background
        G.draw_quad(quad: @quad, color: :blue_dark, z: 10)
      end

      def handle_return
        Us.create_user(name: G.window.text_input.text)
      end
    end
  end
end
