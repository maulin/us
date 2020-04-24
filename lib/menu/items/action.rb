module Menu
  module Item
    class Action
      def initialize(text:, callback:, y_pos:, height:)
        @callback = callback
        @quad = Quad.new(
          Point.new(0, y_pos), Point.new(Menu::WIDTH, y_pos),
          Point.new(0, y_pos + height), Point.new(Menu::WIDTH, y_pos + height)
        )
        @close_button = Quad.new(
          Point.new(370, 20), Point.new(390, 20),
          Point.new(370, 40), Point.new(390, 40)
        )
      end

      def draw
        G.draw_quad(
          p1: @quad.p1, p2: @quad.p2, p3: @quad.p3, p4: @quad.p4,
          color: :white, z: 20
        )
        G.draw_text(
          msg: "#{@object.class}:#{@object.name}", x: 10, y: 10, z: 30,
          size: :medium, color: :black
        )
        G.draw_text(msg: "X", x: 370, y: 10, z: 30, size: :medium, color: :black)
      end

      def handle_click(pos)
        @callback.call if @close_button.contains?(pos)
      end
    end
  end
end
