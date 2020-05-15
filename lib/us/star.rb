module Us
  class Star < GameObject
    SPRITE = Gosu::Image.new(File.expand_path('./assets/visible_star.png'))
    WP_SPRITE = Gosu::Image.new(File.expand_path('./assets/waypoint.png'))

    attr_accessor :mark_for_jump

    def initialize(data)
      super
      @ships = data['ships']
      @bottom_middle = Point.new(@center.x, @center.y + SIZE + 5)
    end

    def build_carrier
      return unless owner.credits >= Server::Game::CARRIER_COST
      Us.update_game(params: { order: ['carrier', @id] })
    end

    def draw_hyperspace_ring
      r = owner.hyperspace_range

      0.step(360, 10) do |i|
        p1 = Point.new(@center.x + Gosu.offset_x(i, r), @center.y + Gosu.offset_y(i, r))
        p2 = Point.new(@center.x + Gosu.offset_x(i + 10, r), @center.y + Gosu.offset_y(i + 10, r))

        G.draw_line(p1: p1, p2: p2, color: :gray, z: 10)
      end
    end

    def draw_jump_marker
      WP_SPRITE.draw(pos.x, pos.y, 10)
    end

    def show_jump_locations
      self.selected = true
      stars = game.jump_locations_from(self)
      stars.each { |s| s.mark_for_jump = true }
    end

    def draw
      draw_hyperspace_ring if selected
      draw_jump_marker if mark_for_jump
      owner.ring.draw(pos.x, pos.y, 10)
      SPRITE.draw(pos.x, pos.y, 10)
      G.draw_text(text: @ships, pos: @bottom_middle, z: 10, size: :tiny)
    end
  end
end
