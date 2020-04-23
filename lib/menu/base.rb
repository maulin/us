module Menu
  class Base
    def initialize(obj, kaller)
      @object = obj
      @caller = kaller
    end

    def draw
      draw_background
      draw_header
    end
    
    def draw_background
      p1 = Point.new(0, 0)
      p2 = Point.new(Menu::WIDTH, 0)
      p3 = Point.new(0, Menu::HEIGHT)
      p4 = Point.new(Menu::WIDTH, Menu::HEIGHT)

      G.draw_quad(p1: p1, p2: p2, p3: p3, p4: p4, color: :gray, z: 10)
    end

    def draw_header
      G.draw_text(msg: "X", x: 370, y: 10, z: 10, size: 30)
    end

    def handle_click(pos)
      pp pos
      close_button = Quad.new(
        Point.new(370, 10),
        Point.new(385, 10),
        Point.new(370, 30),
        Point.new(385, 30),
      )

      @caller.close_menu if close_button.contains?(pos)
    end
  end
end
