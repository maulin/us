module Us
  module Menu
    class Carrier
      def initialize
        @background = Quad.new(
          Point.new(0, 100), Point.new(WIDTH, 100),
          Point.new(0, HEIGHT), Point.new(WIDTH, HEIGHT)
        )
        @title_pos = Point.new(@background.p1.x + 5, @background.p1.y + 10)
        @edit_waypoint_quad = Quad.new(
          Point.new(0, 140), Point.new(WIDTH, 140),
          Point.new(0, 190), Point.new(WIDTH, 190)
        )
      end

      def draw
        return unless @carrier

        G.draw_quad(quad: @background, color: :blue_dark, z: 100)
        G.draw_text(text: @carrier.to_s, pos: @title_pos, z: 100, size: :small)
        draw_edit_waypoint_quad
      end

      def draw_edit_waypoint_quad
        G.draw_quad(quad: @edit_waypoint_quad, color: :blue_middle, z: 100)
        text_pos = Point.new(@edit_waypoint_quad.p1.x + 5, @edit_waypoint_quad.p1.y + 10)
        G.draw_text(text: 'Edit waypoints', pos: text_pos, z: 100, size: :small)
      end

      def show(carrier)
        @carrier = carrier
      end

      def hide
        @carrier = nil
      end

      def visible?
        @carrier ? true : false
      end

      def clicked?(pos)
        @background.contains?(pos)
      end

      def handle_click(pos)
        if @edit_waypoint_quad.contains?(pos)
          @carrier.show_jump_locations
        end
      end
    end
  end
end
