require_relative '../quad'
require_relative '../point'
require_relative '../game_window'

module Us
  module Menu
    class Game
      HEIGHT = 400
      WIDTH = 800

      def initialize
        @quad = Quad.new(
          Point.new((Us::WIDTH - WIDTH) /2, (Us::HEIGHT - HEIGHT) /2),
          Point.new((Us::WIDTH + WIDTH) /2, (Us::HEIGHT - HEIGHT) /2),
          Point.new((Us::WIDTH - WIDTH) /2, (Us::HEIGHT + HEIGHT) /2),
          Point.new((Us::WIDTH + WIDTH) /2, (Us::HEIGHT + HEIGHT) /2),
        )

        offset = @quad.p1
        width = 400
        height = 80
        spacing = 80
        @create_button_quad = Quad.new(
          Point.new((WIDTH - width) / 2 + offset.x, spacing + offset.y),
          Point.new((WIDTH + width) / 2 + offset.x, spacing + offset.y),
          Point.new((WIDTH - width) / 2 + offset.x, height + spacing + offset.y),
          Point.new((WIDTH + width) / 2 + offset.x, height + spacing + offset.y),
        )
        text_offset = (width - G.text_width(text: 'Create Game', size: :medium)) / 2
        @create_text_pos = Point.new(@create_button_quad.p1.x + text_offset, @create_button_quad.p1.y + 10)

        @join_button_quad = Quad.new(
          Point.new((WIDTH - width) / 2 + offset.x, spacing + @create_button_quad.p3.y),
          Point.new((WIDTH + width) / 2 + offset.x, spacing + @create_button_quad.p3.y),
          Point.new((WIDTH - width) / 2 + offset.x, height + spacing + @create_button_quad.p3.y),
          Point.new((WIDTH + width) / 2 + offset.x, height + spacing + @create_button_quad.p3.y),
        )
        text_offset = (width - G.text_width(text: 'Join Game', size: :medium)) / 2
        @join_button_text_pos = Point.new(@create_button_quad.p1.x + text_offset, @join_button_quad.p1.y + 10)
      end

      def draw
        draw_background
      end

      def draw_background
        G.draw_quad(quad: @quad, color: :blue_dark, z: 10)

        G.draw_quad(quad: @create_button_quad, color: :blue_light, z: 20)
        G.draw_text(text: "Create Game", pos: @create_text_pos, z: 30, size: :medium)

        G.draw_quad(quad: @join_button_quad, color: :blue_light, z: 20)
        G.draw_text(text: "Join Game", pos: @join_button_text_pos, z: 30, size: :medium)
      end

      def handle_click(pos)
        if @create_button_quad.contains?(pos)
          Us.create_game
        end
        if @join_button_quad.contains?(pos)
          Us.join_game
        end
      end

      def handle_return
      end
    end
  end
end
