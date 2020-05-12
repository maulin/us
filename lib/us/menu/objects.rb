module Us
  module Menu
    class Objects
      ROW_HEIGHT = 50
      ROW_SPACE = 10
      MENUS = {
        star: Star.new
      }

      def initialize
        @background = Quad.new(
          Point.new(0, 100), Point.new(WIDTH, 100),
          Point.new(0, HEIGHT), Point.new(WIDTH, HEIGHT)
        )
      end

      def show(objects)
        return if objects.empty?

        @objects = objects
        if objects.size == 1
          object = objects.first
          object.selected = true
          @object_menu = MENUS[object.menu_type]
          @object_menu.show(object)
        else
          @object_quads = []
          @objects.each_with_index do |o, i|
            o.selected = true
            start_height = 100 + (i * (ROW_HEIGHT + ROW_SPACE))
            quad = Quad.new(
              Point.new(0, start_height), Point.new(WIDTH, start_height),
              Point.new(0, start_height + ROW_HEIGHT), Point.new(WIDTH, start_height + ROW_HEIGHT)
            )
            @object_quads << quad
          end
        end
      end

      def hide
        @objects.each { |o| o.selected = false } if @objects
        @objects = nil
        @object_quads = nil
        @object_menu = nil
      end

      def visible?
        @objects ? true : false
      end

      def clicked?(pos)
        @background.contains?(pos)
      end

      def handle_click(pos)
        if @object_menu
          @object_menu.handle_click(pos)
        else
          @object_quads.each_with_index do |q, i|
            if q.contains?(pos)
              object = @objects[i]
              show([object])
            end
          end
        end
      end

      def draw
        if @object_menu
          @object_menu.draw
        else
          draw_objects
        end
      end

      def draw_objects
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
