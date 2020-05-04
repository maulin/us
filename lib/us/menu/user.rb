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

        text_input = Gosu::TextInput.new
        text_input.text = "Enter your name"
        window.text_input = text_input
      end

      def draw
        draw_background
        draw_input
      end

      def draw_input
        @font ||= Gosu::Font.new(35, name: 'Fira Mono')
        @font.draw(G.window.text_input.text, 1000, 600, 20)
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
