module Menu
  module Item
    class Action
      HEIGHT = 50

      def initialize(text:, text_size:, action_text:, action_text_size:, callback:, y_pos:)
        @callback = callback
        @y_pos = y_pos

        @action_text_image = G.image_from_text(text: action_text, size: action_text_size)
        @action_text_start = Point.new(Menu::WIDTH - @action_text_image.width - 10, @y_pos + 10)

        @text_start = Point.new(5, @y_pos + 5)
        @text_width = action_quad.p1.x - @text_start.x
        @text_image = G.image_from_text(text: text, size: text_size, options: { width: @text_width })

        @quad = Quad.new(
          Point.new(0, y_pos), Point.new(Menu::WIDTH, y_pos),
          Point.new(0, y_pos + HEIGHT), Point.new(Menu::WIDTH, y_pos + HEIGHT)
        )
      end

      def action_quad
        return @action_quad if @action_quad

        quad_start_x = Menu::WIDTH - @action_text_image.width - 15
        quad_end_x = Menu::WIDTH - 5
        @action_quad = Quad.new(
          Point.new(quad_start_x, @y_pos + 5),
          Point.new(quad_end_x, @y_pos + 5),
          Point.new(quad_start_x, @y_pos + HEIGHT - 5),
          Point.new(quad_end_x, @y_pos + HEIGHT - 5)
        )
      end

      def draw
        G.draw_quad(quad: @quad, color: :white, z: 20)
        G.draw_img(img: @text_image, pos: @text_start, z: 30, color: :black)
        G.draw_quad(quad: action_quad, color: :blue, z: 20)
        G.draw_img(img: @action_text_image, pos: @action_text_start, z: 30, color: :white)
      end

      def handle_click(pos)
        puts "calling handle click"
        @callback.call if action_quad.contains?(pos)
      end
    end
  end
end
