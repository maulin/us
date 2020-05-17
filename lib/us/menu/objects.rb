module Us
  module Menu
    class Objects
      ROW_HEIGHT = 50
      ROW_SPACE = 10

      def initialize
        @background = Quad.new(
          Point.new(0, 100), Point.new(WIDTH, 100),
          Point.new(0, HEIGHT), Point.new(WIDTH, HEIGHT)
        )
      end

      def show(objects)
        @object_quads = []
        @objects = objects

        @objects.each_with_index do |o, i|
          start_height = 100 + (i * (ROW_HEIGHT + ROW_SPACE))
          quad = Quad.new(
            Point.new(0, start_height), Point.new(WIDTH, start_height),
            Point.new(0, start_height + ROW_HEIGHT), Point.new(WIDTH, start_height + ROW_HEIGHT)
          )
          @object_quads << quad
        end
      end

      def clicked?(pos)
        @background.contains?(pos)
      end

      def close_menu_and_rehandle_click(pos)
        Us.game.close_menu
        Us.game.handle_click(pos)
      end

      def handle_click(pos)
        close_menu_and_rehandle_click(pos) unless clicked?(pos)

        @object_quads.each_with_index do |q, i|
          if q.contains?(pos)
            object = @objects[i]
            Us.game.show_menu_for(object)
          end
        end
      end

      def draw
        return unless @object_quads

        G.draw_quad(quad: @background, color: :blue_dark, z: 100)
        @object_quads.each_with_index do |q, i|
          G.draw_quad(quad: q, color: :blue_middle, z: 100)

          object = @objects[i]
          text_pos = Point.new(q.p1.x + 5, q.p1.y + 10)
          G.draw_text(text: object.to_s, pos: text_pos, z: 100, size: :small)
        end
      end
    end
  end
end
