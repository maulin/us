module Us
  module Menu
    class Star
      def initialize
        @background = Quad.new(
          Point.new(0, 100), Point.new(WIDTH, 100),
          Point.new(0, HEIGHT), Point.new(WIDTH, HEIGHT)
        )
        @star_name_pos = Point.new(@background.p1.x + 5, @background.p1.y + 10)
        @carrier_quad = Quad.new(
          Point.new(0, 140), Point.new(WIDTH, 140),
          Point.new(0, 190), Point.new(WIDTH, 190)
        )
      end

      def draw
        return unless @star

        G.draw_quad(quad: @background, color: :blue_dark, z: 100)
        draw_star_name
        draw_carrier_section
      end

      def draw_star_name
        G.draw_text(text: @star.to_s, pos: @star_name_pos, z: 100, size: :small)
      end

      def draw_carrier_section
        G.draw_quad(quad: @carrier_quad, color: :blue_middle, z: 100)
        text_pos = Point.new(@carrier_quad.p1.x + 5, @carrier_quad.p1.y + 10)
        G.draw_text(text: 'Buy a carrier for $25', pos: text_pos, z: 100, size: :small)
      end

      def show(star)
        @star = star
      end

      def hide
        @star = nil
      end

      def visible?
        @star ? true : false
      end

      def clicked?(pos)
        @background.contains?(pos)
      end

      def handle_click(pos)
        if @carrier_quad.contains?(pos)
          @star.build_carrier
        end
      end
    end
  end
end
