module Us
  module Menu
    class Objects
      def initialize
        @background = Quad.new(
          Point.new(0, 100), Point.new(WIDTH, 100),
          Point.new(0, HEIGHT), Point.new(WIDTH, HEIGHT)
        )
      end

      def draw
        return unless @objects

        G.draw_quad(quad: @background, color: :blue_dark, z: 100)
      end

      def show(objects)
        @objects = objects
      end

      def hide
        @objects = nil
      end

      def visible?
        @objects ? true : false
      end

      def clicked?(pos)
        @background.contains?(pos)
      end

      def handle_click(pos)
      end
    end
  end
end
