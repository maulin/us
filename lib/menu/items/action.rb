module Menu
  module Item
    class Action
      HEIGHT = 50

      def initialize(text:, text_size:, action_text:, action_text_size:, callback:, y_pos:)
        @callback = callback
        @text = text
        @text_size = text_size
        @action_text = action_text
        @action_text_size = action_text_size

        @quad = Quad.new(
          Point.new(0, y_pos), Point.new(Menu::WIDTH, y_pos),
          Point.new(0, y_pos + HEIGHT), Point.new(Menu::WIDTH, y_pos + HEIGHT)
        )
        @text_start = Point.new(5, y_pos + 5)

        action_text_width = G.text_width(text: action_text, size: action_text_size)
        action_start_x = Menu::WIDTH - action_text_width - 15
        action_end_x = Menu::WIDTH - 5
        @action_text_start = Point.new(action_start_x + 5, y_pos + 10)
        @action_quad = Quad.new(
          Point.new(action_start_x, y_pos + 5),
          Point.new(action_end_x, y_pos + 5),
          Point.new(action_start_x, y_pos + HEIGHT - 5),
          Point.new(action_end_x, y_pos + HEIGHT - 5)
        )
        @text_width = @action_quad.p1.x - @text_start.x
      end

      def draw
        G.draw_quad(quad: @quad, color: :white, z: 20)
        G.draw_text(
          msg: @text, pos: @text_start, z: 30,
          size: @text_size, color: :black,
          options: { width: @text_width }
        )
        G.draw_quad(quad: @action_quad, color: :blue, z: 20)
        G.draw_text(
          msg: @action_text, pos: @action_text_start, z: 30,
          size: @action_text_size, color: :white,
        )
      end

      def draw_quad

      end

      def handle_click(pos)
        @callback.call if @action_quad.contains?(pos)
      end
    end
  end
end
