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
        Item::Action.new(
          text: "#{obj.class}:#{obj.name}",
          text_size: :medium,
          action_text: "X",
          action_text_size: :medium,
          callback: -> { kaller.close_menu },
          y_pos: 10
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
      G.draw_quad(quad: @quad, color: :gray, z: 10)
    end

    def handle_click(pos)
      @items.each do |i|
        i.handle_click(pos)
      end
    end
  end
end
