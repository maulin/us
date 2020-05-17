module Us
  class Carrier < GameObject
    SPRITE = Gosu::Image.new(File.expand_path('./assets/carrier.png'))

    attr_reader :start, :waypointing

    def initialize(data:, game:)
      super
      @start = game.fetch_star(data['start'])
      @waypoints = [@start]
    end

    def draw
      owner.ring.draw(pos.x, pos.y, 20)
      SPRITE.draw(pos.x, pos.y, 30)
      draw_waypoints
    end

    def draw_waypoints
      @waypoints.each_index do |i|
        s, d = @waypoints[i..i + 1]
        G.draw_line(p1: s.center, p2: d.center, z: 10, color: owner.color) if s && d
      end
      @waypoints.last.show_jump_locations if waypointing
    end

    def start_waypointing
      @waypointing = true
    end

    def stop_waypointing
      @waypointing = false
      @waypoints.last.hide_jump_locations
    end

    def try_set_new_waypoint(pos)
      pos = G.untranslate_and_zoom(pos)
      star = game.fetch_star_at(pos)
      if @waypoints.last.jump_locations.include?(star)
        @waypoints.last.hide_jump_locations
        @waypoints << star
      end
    end

    def waypoints_text
      @waypoints.map(&:name).join(' -> ')
    end
  end
end
