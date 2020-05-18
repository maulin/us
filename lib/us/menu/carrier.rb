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
          Point.new(0, 140), Point.new(WIDTH * 0.40, 140),
          Point.new(0, 190), Point.new(WIDTH * 0.40, 190)
        )
        @save_quad = Quad.new(
          Point.new(WIDTH * 0.40 + 10, 140), Point.new(WIDTH * 0.80, 140),
          Point.new(WIDTH * 0.40 + 10, 190), Point.new(WIDTH * 0.80, 190)
        )
        @close_quad = Quad.new(
          Point.new(WIDTH * 0.80 + 10, 140), Point.new(WIDTH, 140),
          Point.new(WIDTH * 0.80 + 10, 190), Point.new(WIDTH, 190)
        )
        set_waypoints_text_image
      end

      def set_waypoints_text_image
        text = @carrier ? @carrier.waypoints_text : ''

        @waypoints_text_image = G.image_from_text(
          text: text,
          size: :small,
          options: { width: WIDTH }
        )
      end

      def draw
        return unless @carrier

        G.draw_quad(quad: @background, color: :blue_dark, z: 100)
        G.draw_text(text: @carrier.to_s, pos: @title_pos, z: 100, size: :small)
        draw_edit_waypoint_quad
        draw_save_quad
        draw_close_quad
        draw_waypoint_list
      end

      def draw_edit_waypoint_quad
        G.draw_quad(quad: @edit_waypoint_quad, color: :blue_middle, z: 100)
        text_pos = Point.new(@edit_waypoint_quad.p1.x + 5, @edit_waypoint_quad.p1.y + 10)
        G.draw_text(text: 'Edit waypoints', pos: text_pos, z: 100, size: :small)
      end

      def draw_save_quad
        G.draw_quad(quad: @save_quad, color: :blue_middle, z: 100)
        text_pos = Point.new(@save_quad.p1.x + 5, @save_quad.p1.y + 10)
        G.draw_text(text: 'Save', pos: text_pos, z: 100, size: :small)
      end

      def draw_close_quad
        G.draw_quad(quad: @close_quad, color: :blue_middle, z: 100)
        text_pos = Point.new(@close_quad.p1.x + 5, @close_quad.p1.y + 10)
        G.draw_text(text: 'X', pos: text_pos, z: 100, size: :small)
      end

      def draw_waypoint_list
        @waypoints_text_image.draw(@edit_waypoint_quad.p3.x + 5, @edit_waypoint_quad.p3.y + 10, 100)
      end

      def show(carrier)
        @carrier = carrier
        set_waypoints_text_image
      end

      def close_menu
        Us.game.close_menu
        @carrier.stop_waypointing
      end

      def save_waypoints
        @carrier.save_waypoints
      end

      def handle_click(pos)
        close_menu if @close_quad.contains?(pos)

        if @edit_waypoint_quad.contains?(pos)
          @carrier.start_waypointing
        elsif @save_quad.contains?(pos)
          save_waypoints
        elsif @carrier.waypointing
          @carrier.try_set_new_waypoint(pos)
          set_waypoints_text_image
        end
      end
    end
  end
end
