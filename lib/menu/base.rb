module Menu
  class Base
    attr_reader :obj

    def initialize(obj, kaller)
      @obj = obj
      @quad = Quad.new(
        Point.new(0, 0), Point.new(Menu::WIDTH, 0),
        Point.new(0, Menu::HEIGHT), Point.new(Menu::WIDTH, Menu::HEIGHT)
      )
      @items = [
        Item::Header.new(
          "#{obj.class}:#{obj.name}",
          -> { kaller.close_menu }
        )
      ]
    end

    def clicked?(pos)
      @quad.contains?(pos)
    end

    def draw
      draw_background
      @items.each(&:draw)
    end
    
    def draw_background
      G.draw_quad(
        p1: @quad.p1, p2: @quad.p2, p3: @quad.p3, p4: @quad.p4,
        color: :gray, z: 10
      )
    end

    def handle_click(pos)
      @items.each do |i|
        i.handle_click(pos)
      end
    end
  end
end
