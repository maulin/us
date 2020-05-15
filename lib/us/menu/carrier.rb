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
          Point.new(0, 140), Point.new(WIDTH / 2, 140),
          Point.new(0, 190), Point.new(WIDTH / 2, 190)
        )
        @close_edit = Quad.new(
          Point.new(WIDTH / 2 + 10, 140), Point.new(WIDTH, 140),
          Point.new(WIDTH / 2 + 10, 190), Point.new(WIDTH, 190)
        )
      end

      def draw
        return unless @carrier

        G.draw_quad(quad: @background, color: :blue_dark, z: 100)
        G.draw_text(text: @carrier.to_s, pos: @title_pos, z: 100, size: :small)
        draw_edit_waypoint_quad
        draw_close_edit_quad
      end

      def draw_edit_waypoint_quad
        G.draw_quad(quad: @edit_waypoint_quad, color: :blue_middle, z: 100)
        text_pos = Point.new(@edit_waypoint_quad.p1.x + 5, @edit_waypoint_quad.p1.y + 10)
        G.draw_text(text: 'Edit waypoints', pos: text_pos, z: 100, size: :small)
      end

      def draw_close_edit_quad
        G.draw_quad(quad: @close_edit, color: :blue_middle, z: 100)
        text_pos = Point.new(@close_edit.p1.x + 5, @close_edit.p1.y + 10)
        G.draw_text(text: 'Close', pos: text_pos, z: 100, size: :small)
      end

      def show(carrier)
        @carrier = carrier
      end

      def clicked?(pos)
        @background.contains?(pos)
      end

      def close_menu_and_rehandle_click(pos)
        Us.game.close_menu
        Us.game.handle_click(pos)
      end

      def handle_click(pos)
        Us.game.close_menu if @close_edit.contains?(pos)

        if @edit_waypoint_quad.contains?(pos)
          @carrier.start_waypointing
          @waypointing = true
        elsif @waypointing
          @carrier.try_set_new_waypoint
        end
      end
    end
  end
end
