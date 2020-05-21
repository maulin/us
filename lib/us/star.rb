module Us
  class Star < GameObject
    SPRITE = Gosu::Image.new(File.expand_path('./assets/visible_star.png'))
    WP_SPRITE = Gosu::Image.new(File.expand_path('./assets/waypoint.png'))

    attr_accessor :mark_as_waypoint

    def initialize(data:, game:)
      super
      @ships = data['ships']
      @bottom_middle = Point.new(@center.x, @center.y + SIZE + 5)
    end

    def build_carrier
      return unless owner.credits >= Server::Game::CARRIER_COST
      Us.update_game(params: {
        order: {
          order: 'carrier',
          id: @id,
        }
      })
    end

    def draw_hyperspace_ring
      r = owner.hyperspace_range

      0.step(360, 10) do |i|
        p1 = Point.new(@center.x + Gosu.offset_x(i, r), @center.y + Gosu.offset_y(i, r))
        p2 = Point.new(@center.x + Gosu.offset_x(i + 10, r), @center.y + Gosu.offset_y(i + 10, r))

        G.draw_line(p1: p1, p2: p2, color: :gray, z: 10)
      end
    end

    def draw_waypoint_marker
      WP_SPRITE.draw(pos.x, pos.y, 10)
    end

    def waypoint_locations
      game.waypoint_locations_from(self)
    end

    def hide_waypoint_locations
      self.selected = false
      self.mark_as_waypoint = false
      stars = waypoint_locations
      stars.each { |s| s.mark_as_waypoint = false }
    end

    def show_waypoint_locations
      self.selected = true
      self.mark_as_waypoint = true
      stars = waypoint_locations
      stars.each { |s| s.mark_as_waypoint = true }
    end

    def draw
      draw_hyperspace_ring if selected
      draw_waypoint_marker if mark_as_waypoint
      owner.ring.draw(pos.x, pos.y, 10)
      SPRITE.draw(pos.x, pos.y, 10)
      G.draw_text(text: @ships, pos: @bottom_middle, z: 100, size: :tiny)
    end
  end
end
