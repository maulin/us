module Us
  module Menu
    class TextField < Gosu::TextInput
      def filter(text)
        text.gsub(/\D*/, '')
      end
    end

    class Carrier
      def initialize
        @background = Quad.new(
          Point.new(0, 100), Point.new(WIDTH, 100),
          Point.new(0, HEIGHT), Point.new(WIDTH, HEIGHT)
        )
        @title_pos = Point.new(@background.p1.x + 5, 130)
        @close_menu_quad = Quad.new(
          Point.new(WIDTH * 0.90 + 10, 120), Point.new(WIDTH, 120),
          Point.new(WIDTH * 0.90 + 10, 170), Point.new(WIDTH, 170)
        )
        @close_menu_text_pos = Point.new(@close_menu_quad.p1.x + 5, @close_menu_quad.p1.y + 5)

        @edit_waypoint_quad = Quad.new(
          Point.new(0, 190), Point.new(WIDTH * 0.3, 190),
          Point.new(0, 240), Point.new(WIDTH * 0.3, 240)
        )
        @edit_waypoint_text_pos = Point.new(@edit_waypoint_quad.p1.x + 5, @edit_waypoint_quad.p1.y + 10)

        @save_waypoint_quad = Quad.new(
          Point.new(WIDTH * 0.3 + 10, 190), Point.new(WIDTH * 0.6, 190),
          Point.new(WIDTH * 0.3 + 10, 240), Point.new(WIDTH * 0.6, 240)
        )
        @save_waypoint_text_pos = Point.new(@save_waypoint_quad.p1.x + 5, @save_waypoint_quad.p1.y + 10)

        @reset_waypoint_quad = Quad.new(
          Point.new(WIDTH * 0.6 + 10, 190), Point.new(WIDTH, 190),
          Point.new(WIDTH * 0.6 + 10, 240), Point.new(WIDTH, 240)
        )
        @reset_waypoint_text_pos = Point.new(@reset_waypoint_quad.p1.x + 5, @reset_waypoint_quad.p1.y + 10)
        @waypoint_list_text_pos = Point.new(@background.p1.x + 5, 260)

        G.window.text_input = TextField.new
        @order_quads = []
      end

      def draw
        return unless @carrier

        G.draw_quad(quad: @background, color: :blue_dark, z: 100)
        G.draw_text(text: @carrier.to_s, pos: @title_pos, z: 100, size: :medium)
        draw_close_menu_quad
        draw_edit_waypoint_quad
        draw_save_quad
        draw_reset_quad
        draw_waypoint_list
      end

      def draw_close_menu_quad
        G.draw_quad(quad: @close_menu_quad, color: :blue_middle, z: 100)
        G.draw_text(text: 'X', pos: @close_menu_text_pos, z: 100, size: :medium)
      end

      def draw_edit_waypoint_quad
        G.draw_quad(quad: @edit_waypoint_quad, color: :blue_middle, z: 100)
        G.draw_text(text: 'Edit', pos: @edit_waypoint_text_pos, z: 100, size: :small)
      end

      def draw_save_quad
        G.draw_quad(quad: @save_waypoint_quad, color: :blue_middle, z: 100)
        G.draw_text(text: 'Save', pos: @save_waypoint_text_pos, z: 100, size: :small)
      end

      def draw_reset_quad
        G.draw_quad(quad: @reset_waypoint_quad, color: :blue_middle, z: 100)
        G.draw_text(text: 'Reset', pos: @reset_waypoint_text_pos, z: 100, size: :small)
      end

      def draw_waypoint_list
        G.draw_text(text: 'Waypoint orders', pos: @waypoint_list_text_pos, z: 100, size: :medium)
        @order_quads = []

        @carrier.waypoints.each_with_index do |w, i|
          y_pos = 320 + i * 60
          q = Quad.new(
            Point.new(@background.p1.x + 20, y_pos + 20),
            Point.new(@background.p1.x + 480, y_pos + 20),
            Point.new(@background.p1.x + 20, y_pos + 60),
            Point.new(@background.p1.x + 480, y_pos + 60),
          )
          @order_quads << q

          star, order = w
          G.draw_quad(quad: q, color: :blue_middle, z: 100)
          text_pos = Point.new(q.p1.x + 5, q.p1.y + 5)
          G.draw_text(text: star.name, pos: text_pos, z: 100, size: :small)

          if @selected_order_index == i
            order = G.window.text_input.text
          end
          order_pos = Point.new(q.p1.x + 300, q.p1.y + 5)
          G.draw_text(text: order, pos: order_pos, z: 100, size: :small)
        end
      end

      def show(carrier)
        @carrier = carrier
      end

      def close_menu
        Us.game.close_menu
        @carrier.stop_waypointing
      end

      def save_waypoints
        @carrier.save_waypoints
      end

      def order_quad_clicked?(pos)
        @order_quads.index { |q| q.contains?(pos) }
      end

      def set_text_input(pos)
        i = @order_quads.index { |q| q.contains?(pos) }

        if @selected_order_index
          pp @carrier.waypoints[@selected_order_index]
          @carrier.waypoints[@selected_order_index][1] = G.window.text_input.text
        end

        @selected_order_index = i
        G.window.text_input.text = @carrier.waypoints[@selected_order_index].last
      end

      def handle_click(pos)
        close_menu if @close_menu_quad.contains?(pos)

        if @edit_waypoint_quad.contains?(pos)
          @carrier.start_waypointing
        elsif @save_waypoint_quad.contains?(pos)
          save_waypoints
        elsif @reset_waypoint_quad.contains?(pos)
          @carrier.reset_waypoints
        elsif @carrier.waypointing
          @carrier.try_set_new_waypoint(pos)
        else order_quad_clicked?(pos)
          set_text_input(pos)
        end
      end
    end
  end
end
